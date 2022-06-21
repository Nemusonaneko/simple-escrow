//SPDX-License-Identifier: None
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockToken is ERC20 {
  constructor() ERC20("token", "TOKEN") {
  }

  function mint() external {
    _mint(msg.sender, 10000 * (10 ** 18));
  }
}