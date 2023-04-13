//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract calculate {

    address public owner;

    event whiteListAddress(address indexed, uint256);

    constructor(address user){
        isExist[user]=true;
        owner=msg.sender;

    }

    mapping(address=> bool) public isExist;
    uint result;
    

    function SetWhiteList(address user) public{
        if(msg.sender==owner)
            isExist[user]=true;
        else
            revert("not accessible");

        emit whiteListAddress(user, block.timestamp);

    }

    function add(uint value1, uint value2) public{
        if(isExist[msg.sender]){
            result= value1 + value2;
        }
        else{
            revert("user is not in whitelist");
        }
    }

    function resultShow()public view returns(uint){
        return result;
    }


}

