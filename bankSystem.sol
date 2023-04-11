// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MyToken is ERC20 {
    constructor() ERC20("MyToken", "MTK"){
         _mint(msg.sender, 10000000000*10**18);
    }    
    
}

contract bankingSystem{

    struct Register{
        uint id;
        string name;
        address Address;
        uint phNo;
        uint accountBalance; 
    }

    address public owner;
    address public tokenAddress;


    constructor(address _tokenAddress){
        tokenAddress = _tokenAddress;
        owner=msg.sender;
    }

    mapping(uint => Register) public userRegistration;

    function clientRegistration(uint ID, string memory userName, uint clientNo) public{
        Register memory record;

        record.id = ID;
        record.name = userName;
        record.phNo = clientNo;
        record.Address = msg.sender; 

        userRegistration[ID] = record;

    }

    function clientDeposit(uint ID, uint Amount) public {
        Register storage depositAmount;
        depositAmount = userRegistration[ID];
        depositAmount.accountBalance += Amount; 

        IERC20(tokenAddress).transferFrom(msg.sender, address(this), Amount);
    }

    function sendingAmount( uint ID, uint Amount) public {
        address recieverAddress = userRegistration[ID].Address;
        IERC20(tokenAddress).transferFrom(msg.sender,recieverAddress,Amount);
    }

    function sendAmount(uint senderId, uint rcvrId, uint amount) public {
        Register storage sender = userRegistration[senderId];
        Register storage rcvr = userRegistration[rcvrId];
        require(sender.accountBalance >= amount,  "In valid Amount");
        sender.accountBalance -= amount;
        rcvr.accountBalance += amount;
    }

    function withdrawAmount(uint Amount) public {
        Register storage withdraw;
        withdraw = userRegistration[Amount];
        require(withdraw.accountBalance >= Amount, "in valid amount");

        IERC20(tokenAddress).transfer(msg.sender,Amount);
    }

    function emergencyWithDraw(uint Amount) public{
        Register storage emergWithDraw;
        emergWithDraw = userRegistration[Amount];    
        IERC20(tokenAddress).transfer(owner,Amount);
    }

}
