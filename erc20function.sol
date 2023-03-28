// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract example {

    constructor() {
        _mint(msg.sender, 1000000000 *10**18);
        total_supply = 1000000000 *10**18;
    }

    mapping(address => uint) public balance;
    mapping(address => uint) public allowence; 

    uint total_supply;

    function totalsupply() public view returns(uint){
        return total_supply;
    }
    function _mint(address _userAddress, uint256 _amount) public{
        balance[_userAddress] = _amount;
    }

    function balanceof(address checkbalance) public view returns(uint){
        return balance[checkbalance];
    }

    function transfer(address to, uint amount) public{
        balance[msg.sender] = amount;
        balance[to] +=amount;
    }

    function transferfrom(address from, address to, uint amount) public{
    
        require(amount < allowence[from], "not authorized");
        require(amount <= balance[from], "amount must be less than from");

        balance[from] -= amount;
        balance[to] += amount;   
    }

    function approve(address from, uint amount) public{
        allowence[from] += amount;
    }

 }  
