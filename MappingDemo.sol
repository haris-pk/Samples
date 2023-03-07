//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract demo{

    //mapping(address => bol) public studentNames;

    function set(uint rollNo, string memory Name) public{
        //studentNames[rollNo]=Name;
    }

    function getmsgSender() public view returns(address){
        return msg.sender;
    }

}