// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract example {

    constructor() {
        _mint(msg.sender, 1000000000 *10**18);
        total_supply = 1000000000 *10**18;
    }

    mapping(address => uint) public balance;
    //mapping(address => uint) public allowence;
    mapping(address => mapping(address => uint256)) public allowence; 

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
    
        require(amount < allowence[from][msg.sender], "not authorized");
        balance[from] -= amount;
        balance[to] += amount;
        allowence[from][msg.sender] -= amount;   
    }

    function approve(address spender, uint amount) public{
        allowence[msg.sender][spender] += amount;
    }

 }  
