//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract example{

    uint[] balance;

    function arraySequence(uint anynumber) public {
        balance.push(anynumber + 1);

    }
    function result() public view returns (uint256[] memory) {
        return balance;
    }


}