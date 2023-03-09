//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SellPurchase{

    struct LandRecord{
        string name;
        address owner;
        uint price;
        uint area_sq;
    }

    mapping(uint=> LandRecord) public checkRecord;

    function SellRecord(uint CheckID,string memory name,uint price,uint areaSqFoot) public{
        LandRecord memory Record;
        Record.name=name;
        Record.owner=msg.sender;
        Record.price=price;
        Record.area_sq=areaSqFoot;
        checkRecord[CheckID] = Record;
    }

    function PurchaseRecord(uint propertyID) public payable{
       LandRecord storage updateRecord;
       updateRecord = checkRecord[propertyID];
      updateRecord.owner = msg.sender;

    }
 


}