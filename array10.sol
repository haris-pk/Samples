//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract task{

    uint[5] data;

    function setarray(uint[] memory value) public {
        for(uint x=0; x<value.length; x++){
            data[x] = value[x];
        }
    }

    function getarray() public view returns(uint[5] memory){
        return data;
    }

    function addArray() public{
        for(uint x=0; x < data.length; x++){
            if(data[x] == 4 )
            data[x] += 6;
        }
    }


}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract VehicleShowroom {
    struct Vehicle {
        string name;
        uint price;
        bool sold;
    }

    Vehicle[] showRoomVehicle;
    address owner;

    constructor() {
        owner = msg.sender;
    }

    function addVehicle(string memory _name, uint _price) public {
        require(msg.sender == owner, "Only the owner can add vehicles");
        showRoomVehicle.push(Vehicle(_name, _price, false));
    }

    function getVehicles() public view returns (string[] memory) {
        string[] memory vehicleList = new string[](showRoomVehicle.length);
        for (uint i = 0; i < showRoomVehicle.length; i++) {
            vehicleList[i] = showRoomVehicle[i].name;
        }
        return vehicleList;
    }

    function buyVehicle(uint _index) public {
        require(_index < showRoomVehicle.length, "Invalid index");
        require(!showRoomVehicle[_index].sold, "Vehicle already sold");
        require(msg.sender != owner, "Owner cannot buy their own vehicle");
        require(msg.sender.balance >= showRoomVehicle[_index].price, "Insufficient funds");

        showRoomVehicle[_index].sold = true;
        payable(owner).transfer(showRoomVehicle[_index].price);
    }
}
