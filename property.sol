// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MyToken is ERC20 {
    constructor() ERC20("MyToken", "MTK") {
        _mint(msg.sender, 10000000000*10**18);
    }
}

contract propertySystem{
    address owner;
    address public tokenAddress; 

    constructor(){
        owner=msg.sender;
    }

    struct sellProperty{
        uint id;
        string propertyname;
        string propertylocation;
        address owner;
        uint propertyprice;
        bool sold;
    }

    mapping(uint => sellProperty)public propertyForSell;

    function sellingProperty(uint propertyID, string memory propertyName, string memory propertyLocation,uint Price) public {
        sellProperty memory record;
        record.id = propertyID;
        record.propertyname = propertyName;
        record.propertylocation = propertyLocation;
        record.propertyprice = Price;
        record.owner = msg.sender;

        propertyForSell[propertyID] = record;
    }

    function propertyToBuy(uint ID) public{
        sellProperty storage property_Sell;
        property_Sell = propertyForSell[ID];
        address currentOwner =property_Sell.owner;
        uint _amount = property_Sell.propertyprice;
        IERC20(tokenAddress).transferFrom(msg.sender,currentOwner,_amount);
        property_Sell.owner=msg.sender;
        property_Sell.sold=true;
    }



}

