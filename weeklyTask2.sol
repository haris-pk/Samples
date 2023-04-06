//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract property{

    struct propertyDetails{
        uint propertyno;
        string propertyname;
        string propertydetails;
        address owner;
        uint price;
        bool sold;

    }

    mapping(uint => propertyDetails) public propertySell;
    mapping(uint => propertyDetails) public propertyList;

    address owner;
    propertyDetails[] listofProperty;

    constructor(){
        owner=msg.sender;
    }

    function SellingProperty( uint propertyID, uint PropertyNo, string memory propertyName,string memory PropertyDetails, uint Price) public {
        require(owner==msg.sender, "only owner can sell the property");
        propertyDetails memory record;
        record.propertyno = PropertyNo;
        record.propertyname = propertyName;
        record.propertydetails = PropertyDetails;
        record.price = Price;
        record.sold = false;

        propertySell[propertyID] =record; 
        listofProperty.push(record);


    }

    function buyingproperty(uint propertyID) public payable {
        propertyDetails storage updateRecord;
        updateRecord = propertySell[propertyID];
        require(msg.value >=updateRecord.price,"not required amount" );
        updateRecord.owner =msg.sender;
        updateRecord.sold = true;
  

    }

    function listofrecord(uint propertyID) public returns(uint) {
        propertyDetails memory list;
        propertyList[record] = list;
        propertyList




    }
    fallback() external payable{}
    receive() external payable{}
}