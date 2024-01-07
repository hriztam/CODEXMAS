// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

contract Challenge09 {
    function getRandomNumber() public view returns (uint256) {
        return (uint256(keccak256(
            abi.encodePacked(block.timestamp, blockhash(block.number - 1))
            )) % 10000);
    }
}