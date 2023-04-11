// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


contract bankingsystem{

    address payable public Owner;

    constructor() payable {
        Owner = payable(msg.sender);
    }

    function deposit() public payable {}

    function withdraw() public {
        // get the amount of Ether stored in this contract
        uint amount = address(this).balance;
        (bool success, ) = Owner.call{value: amount}("");
        require(success, "Failed to send Ether");
    }

    function transfer(address payable _to, uint _amount) public {
        // Note that "to" is declared as payable
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Failed to send Ether");
    }



}