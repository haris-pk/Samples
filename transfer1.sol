// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract example{


    mapping(address => uint) public balance;
    mapping(address => mapping(address => uint)) public allowence;

    uint total_supply;

    constructor(){
        mint(msg.sender, 1000 * 10**18);
        total_supply = 1000 * 10**18;

    } 

    function mint(address userAddress, uint amount) public{
        require(userAddress != address(0), "mint the zero address");
        balance[userAddress] += amount;
    }

    function totalsupply() public view returns(uint){
        return total_supply;
    }

    function balanceof(address checkbalance) public view returns(uint){
        return balance[checkbalance];
    }

    function transfer(address to, uint amount) public{
        require(to != address(0),"transfer to zero address not possible");
        balance[msg.sender] -= amount;
        balance[to] +=amount;
    }

    function transferfrom(address from, address to, uint amount) public{
        require(amount < allowence[from][msg.sender], "not authorized");
        require(to != address(0),"transfer to zero address not possible");
        balance[from] -= amount;
        balance[to] += amount;
        allowence[from][msg.sender] -= amount;
    }

    function approve(address spender,uint amount) public{
          require(spender != address(0), "approve to zero address");
          allowence[msg.sender][spender] += amount;
    }  
  
}

