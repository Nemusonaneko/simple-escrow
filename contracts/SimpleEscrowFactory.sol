// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity 0.8.15;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "./SimpleEscrowContract.sol";

contract SimpleEscrowFactory {
    using SafeERC20 for IERC20;

    address immutable public llama;

    event EscrowCreated(address escrow, address payer, address payee, address token, uint amount);

    constructor(address _llama) {
        llama = _llama;
    }

    function createEscrow(address _payee, address _token, uint _amount) external returns(address simpleEscrowContract) {
        simpleEscrowContract = address(new SimpleEscrowContract(msg.sender, _payee, llama, _token));
        IERC20 token = IERC20(_token);
        token.safeTransferFrom(msg.sender, address(this), _amount);
        token.safeApprove(simpleEscrowContract, _amount);
        token.safeTransfer(simpleEscrowContract, _amount);
        emit EscrowCreated(simpleEscrowContract, msg.sender, _payee, _token, _amount);
    }
}