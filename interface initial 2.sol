// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface ICounter{
    function count() external view returns(uint);
    function increment() external;
}

contract interation{
    address counterAddress;

    function setCounterAddress(address counter) public payable {
        counterAddress = counter;
    }

    function getcount() external view returns (uint){
        return ICounter(counterAddress).count();
    }
}