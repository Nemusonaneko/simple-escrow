// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity 0.8.15;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

error notPayer();
error notPayee();
error notLlama();
error notDisputed();
error notPayerOrPayee();
error notValidRecipient();

contract SimpleEscrowContract {
    using SafeERC20 for IERC20;

    address immutable public payer;
    address immutable public payee;
    address immutable public llama;
    IERC20 immutable public token;
    bool public disputed;
     
    constructor(address _payer, address _payee, address _llama, address _token) {
        payer = _payer;
        payee = _payee;
        llama = _llama;
        token = IERC20(_token);
    }

    function releaseFunds() external {
        if (msg.sender != payer) revert notPayer();
        uint toSend = token.balanceOf(address(this));
        token.safeTransfer(payee, toSend);
    }

    function returnFunds() external {
        if (msg.sender != payee) revert notPayee();
        uint toSend = token.balanceOf(address(this));
        token.safeTransfer(payer, toSend);
    }

    function dispute() external {
        if(msg.sender != payer && msg.sender != payee) revert notPayerOrPayee();
        disputed = !disputed;
    }

    function sendFunds(address _recipient) external {
        if (msg.sender != llama) revert notLlama();
        if (!disputed) revert notDisputed();
        if (_recipient != payer && _recipient != payee) revert notValidRecipient();
        uint toSend = token.balanceOf(address(this));
        token.safeTransfer(_recipient, toSend);
    }
}