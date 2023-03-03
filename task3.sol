//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SampleExample{ 
    constructor(){}

    function checkmark(uint a, uint b) public pure returns(uint) {
    if(a>=b){
        return a;
    }
    else{
        return b;
    }
}
}