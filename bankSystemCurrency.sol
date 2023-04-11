// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract bankingSystem {

    struct Register {
        uint id;
        string name;
        address _address;
        uint phNo;
        uint accountbalance;
    }

    address payable public owner;

    constructor() payable {
        owner =payable(msg.sender);
    }


    mapping(uint => Register) public userRegistration;

    function clientRegistration(uint ID, string memory Name, uint PhNo) public payable {
            Register memory record;

            record.id = ID;
            record.name = Name;
            record._address = msg.sender;
            record.phNo = PhNo;

            userRegistration[ID] = record;
    }
   

    function clientDeposit(uint ID, uint _amount) public payable{
         Register storage depositAmount;
         depositAmount = userRegistration[ID];
         depositAmount.accountbalance += _amount;


    }

    function sendAmount(uint senderId, uint receiverId, uint amount) public {
        Register storage sender;
        Register storage reciever;
        sender =  userRegistration[senderId];
        reciever = userRegistration[receiverId];

        sender.accountbalance -= amount;
        reciever.accountbalance += amount;

    }

    function withdrawAmount(uint amount) public payable{
        Register storage withdraw;

        withdraw = userRegistration[amount];
        withdraw.accountbalance -= amount;


    }



    fallback() external payable{}
    receive() external payable{}


}