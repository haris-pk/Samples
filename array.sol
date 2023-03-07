//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract example{
    
address public owner;
constructor (){
    isExist[msg.sender]=true;
    owner = msg.sender;
}

    mapping(address => bool) public isExist;
    uint result;


    function SetWhiteList( address user) public{
        if(msg.sender==owner){
            isExist[user]=true;
        }
        else{
            revert("not accessible");
        }
 
    }

    function add( uint num1, uint num2) public{
        if(isExist[msg.sender]){
            result=num1 + num2;
        }
        else{
            revert("user is not in white list");
        }
    }

    function resultShow() public view returns(uint){
        return result;
    }