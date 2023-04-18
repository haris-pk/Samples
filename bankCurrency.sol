// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract BankingSystem{

    address public owner;
    mapping(address => uint256) public balance;
    mapping(address =>bool) public blacklist;
    mapping(address =>bool) public restrictedList;

     constructor() {
        owner = msg.sender;
    }

    function deposit() public payable {
        require(!blacklist[msg.sender],"user is blacklisted can not deposit");        
        require(msg.value > 0, "Deposit amount must be greater than 0");
        balance[msg.sender] += msg.value;
        
    }
    /**
        user in restricted list can deposit but cannot withdraw
        user in blacklist can not deposit and withdraw
     */
    function withdraw(uint amount) public payable {
        require(!restrictedList[msg.sender], "user is in restricted List can not withdraw");
        require(!blacklist[msg.sender],"user is blacklisted can not withdraw");        
        require(amount > 0, "Withdraw amount must be greater than 0");
        require(amount <= balance[msg.sender], "amount is greater than your balance");
        payable(msg.sender).transfer(address(this).balance);
        balance[msg.sender] -= amount;
        
    }

    function sendFunds(address sender, uint amount) public {
        require(amount > 0, "Transfer amount must be greater than 0");
        balance[msg.sender] -= amount;
        balance[sender] += amount;
    }

    function getBalance() public view returns (uint) {
        return balance[msg.sender];
    }

    function emergencyWithdraw() public payable {
        require(msg.sender == owner, "Only owner");
        payable(msg.sender).transfer(address(this).balance);
    }

    function setBlackList(address user) onlyOwner public{
        require(!blacklist[user], " black listed");
        blacklist[user] = true;

    }
        
    function setRestrictedList(address user) onlyOwner public{
        require(!restrictedList[user], "already restricted");
        restrictedList[user]=true;

    }

    modifier onlyOwner() {
        require(owner == msg.sender, "caller is not the owner");
        _;
    }

    fallback() external payable{}
    receive() external payable{}
    

}