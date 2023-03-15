//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract vehicleShowRoom{

    struct ListofVehicle{
        string name;
        uint price;
        address owner;
        bool sold; 
    }
    address owner;

    uint256 public count;

    constructor() {
        owner = msg.sender;
    }

    ListofVehicle[] vehicleRecords;                                                                                                                                                                                                                                                                                                                                                                                                                                                         
    mapping(uint=> ListofVehicle) public showVehicle;
    mapping(uint256 => uint256) public indexOf;

    function addvehicle(uint vehicleID,string memory Name,uint Price) public{
        require(msg.sender== owner, "only owner can add the vehicle");
        ListofVehicle memory Record;
        Record.name=Name;
        Record.price=Price;
        Record.owner=msg.sender;
        showVehicle[vehicleID] = Record;
        indexOf[vehicleID] = count;
        vehicleRecords.push(Record);
        Record.sold=false;
        count++;
    }

    function buytheVehicle(uint vehicleID) public payable{
        ListofVehicle storage updateRecord;
        updateRecord =showVehicle[vehicleID];
        require(msg.value >= updateRecord.price, "ennay paisy nae teray kol, chl pj ja");
        updateRecord.owner =msg.sender;
        updateRecord.sold = true;

        uint256 index = indexOf[vehicleID];
        vehicleRecords[index] = updateRecord;

    }

    function getRecords() public view returns(ListofVehicle[] memory){
        return vehicleRecords;
    }

    fallback() external payable{}
    receive() external payable{}
}
