// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract bankingSystem{

    address public owner;

    mapping(address => uint) public balance;

     constructor() {
        owner = msg.sender;
    }

    function deposit() public payable {
        balance[msg.sender] += msg.value;
    }
    function withdraw(uint amount) public payable {
        balance[msg.sender] -= amount;
    }
    function getBalance() public view returns (uint) {
        return balance[msg.sender];
    }

    fallback() external payable{}
    receive() external payable{}
    

}