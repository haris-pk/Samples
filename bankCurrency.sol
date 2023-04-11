// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract bankingSystem{

    address public owner;
    mapping(address => uint) public balance;

     constructor() {
        owner = msg.sender;
    }

    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        balance[msg.sender] += msg.value;
    }
    function withdraw(uint amount) public payable returns(uint) {
        require(amount > 0, "Withdraw amount must be greater than 0");
        balance[msg.sender] -= amount;
        return balance[msg.sender];
    }
    function sendFunds(address Sender, uint amount) public {
    require(amount > 0, "Transfer amount must be greater than 0");
    balance[msg.sender] -= amount;
    balance[Sender] += amount;
}
    function getBalance() public view returns (uint) {
        return balance[msg.sender];
    }

    function emergencyWithdraw(address _sender,uint amount) public payable {
    require(msg.sender == owner, "Only owner");
    require(amount > 0, "Withdraw amount must be greater than 0");
    balance[_sender] -= amount;
}

    fallback() external payable{}
    receive() external payable{}
    

}