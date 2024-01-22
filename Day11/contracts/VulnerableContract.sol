// SPDX-License-Identifier: MIT

pragma solidity 0.8.21;

contract BecomeKing {

    uint256 public balance;
    address public king;

    function claimThrone() external payable {
        
        require(msg.value > balance, "Send More ether!");

        (bool sent, ) = king.call{value : balance}("");
        require(sent, "Transaction failed");

        king = msg.sender;
        balance = msg.value;
    }
}