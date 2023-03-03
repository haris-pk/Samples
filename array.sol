//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract example{

    uint[] balance;

    function arrayCheck(uint256 anyNumber) public {
        balance.push(anyNumber);
    }

    function checkArray() public pure returns(uint[5] memory){
        uint[5] memory data = [uint(50), 63, 77, 28, 90];
        return data;
    }

    function getDynmaicArray() public view returns(uint256[] memory){
        return balance;
    }


}