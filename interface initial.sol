// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract counter{
    uint public count;

    function increment() external{
        count +=1;
    } 

}
