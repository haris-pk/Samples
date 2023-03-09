//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract vehicleShowRoom{

    struct ListofVehicle{

        string name;
        uint price;
        address owner; 
    }

    mapping(uint=> ListofVehicle) public showVehicle; 
    address owner;

    constructor(){
        owner=msg.sender;
    }

    function addvehicle(uint CheckID,string memory Name,uint Price) public{
        require(msg.sender== owner, "only owner can add the vehicle");
        ListofVehicle memory Record;
        Record.name=Name;
        Record.price=Price;
        Record.owner=msg.sender;
        showVehicle[CheckID] = Record;

    }

    function buytheVehicle(uint vehicleID) public payable{
        ListofVehicle storage updateRecord;
        updateRecord =showVehicle[vehicleID];
        require(msg.value >= updateRecord.price, "ennay paisy nae teray kol, chl pj ja");
        updateRecord.owner =msg.sender;
    }

    fallback() external payable{}
    receive() external payable{}