//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract example{

    mapping(address =>uint) public balance;
    mapping(address =>uint) public allowence;


    function transfer(address to, uint amount) public{
        balance[msg.sender] -= amount;
        balance[to] += amount;
    }

    function transferfrom(address to, address from, uint amount) public{
        require(amount < balance[from],"amount must be less than from");
        require(amount < allowence[from],"un authorized");
        balance[from] -= amount;
        balance[to]  += amount;
    }

    function approve(uint amount, address from) public{
        allowence[from] += amount;
        
    }

}
