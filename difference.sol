//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract difference {

    string private myName;
    address owner;

    constructor() {
        myName = "Haris";
        owner=msg.sender;
        
    }

    mapping(address=> bool) public isAllow;
    function addition(uint num2, uint num3) public pure returns(uint){
        return num2 + num3;
    }

    function getName() public view returns(string memory){
        return myName;
    }
    function setAddresstoAllow(address user) public{
        if(msg.sender==owner)
            isAllow[user]=true;
        else
            revert("not allowed to change the name");

    }

    function setName(string memory changeName) public{
       require(isAllow[msg.sender] == true, "you are not allowed");
        myName = changeName;
    }

    function getMsgSender() public view returns(address){
        return msg.sender;
    }
}

interface IDifference{
    function addition(uint num2, uint num3) external pure returns(uint);
    function getName() external view returns(string memory);
    function setName(string memory changeName) external ;
    function getMsgSender() external view returns(address);
}

contract myContract{

    address public userContract;
    constructor(address _userContract) {
        userContract = _userContract;
    }

    function myAddition(uint256 num2, uint256 num3) public view returns(uint256){
        return IDifference(userContract).addition(num2, num3);
    }

    function getContractName() public view returns(string memory, address _msgsender){
         return (IDifference(userContract).getName(), msg.sender);

    }
    function setContractName(string memory changeName) public {
        IDifference(userContract).setName(changeName);
    }

    function getSender() public view returns(address){
        return IDifference(userContract).getMsgSender();
    }

}