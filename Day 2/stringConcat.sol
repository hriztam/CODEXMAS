// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ChristmasContract {
    function combining(string memory str) public pure returns (string memory) {
        return string.concat(str, " Merry Christmas!");
    }
}
