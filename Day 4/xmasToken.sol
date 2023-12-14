// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract XmasToken is ERC20 {
    constructor() ERC20("XmasToken", "XMAS") {
        uint256 initialSupply = 10000 * (10 ** uint256(decimals()));
        _mint(msg.sender, initialSupply);
    }
}
