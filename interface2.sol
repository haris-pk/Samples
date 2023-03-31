// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./interface.sol";

contract calculate is calculator{
    function getResult() external pure override returns(uint){
        uint a = 1;
        uint b = 2;
        uint result = a+b;
        return result;
    }
    function multiply() external pure override returns(uint){
            uint a= 5;
            uint b= 6;
            uint result = a*b;
            return result;
        }
}