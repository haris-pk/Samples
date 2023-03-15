//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract vehicleShowRoom{

    struct ListofVehicle{
        string name;
        uint price;
        bool sold;
        address owner;
    }

    address Owner;
    ListofVehicle[] vehicleRecords;
    uint public count;

    constructor(){
        Owner=msg.sender;
    }

    mapping(uint => ListofVehicle) public showVehicle;
    mapping(uint => uint) public indexOf;   


    function addVehicle(uint vehicleID, string memory Name, uint Price) public{
        require(msg.sender==Owner,"only owner can add the vehicle");
        ListofVehicle memory Record;
        Record.name=Name;
        Record.price=Price;
        Record.owner=msg.sender;
        showVehicle[vehicleID]=Record;
        Record.sold=false;
        vehicleRecords.push(Record);
    }

    function buyVehicle(uint vehicleID) public payable{
        uint data;
        ListofVehicle storage updateRecord;
        updateRecord = showVehicle[vehicleID];
        require(msg.value >=updateRecord.price,"not Required Amount");
        updateRecord.owner =msg.sender;
        updateRecord.sold =true;
        data = indexOf[vehicleID];

    }

}