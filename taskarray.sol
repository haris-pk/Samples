//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract arraytask{

    uint[]  arrayshow;

   function arraySequence(uint256 number) public returns(uint256[] memory) {
       
        arrayshow.push(number);
        return arrayshow;
    
    }


}