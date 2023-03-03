//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract arraytask{


   function arraySequence(uint256 number) public returns(uint256[] memory) {
       uint[] memory arrayshow;
        arrayshow.push(number);
        return arrayshow;
    
    }


}