//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract trasnfer{

    address public contractOwner;

    constructor(){
        contractOwner=msg.sender;
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function buy() public payable{
        require(msg.value >= amount, "not enough");
        owner = msg.sender;
    }


}