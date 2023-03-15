//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Team{

    struct Player{
        uint playerno;
        string name;
        string  job;
        string category;
        uint salary;
        bool sold;
        uint price;
    }

    address TeamOwner;
    

    constructor(){
        TeamOwner = msg.sender;
    }

    mapping(uint => Player) public playerDetails;

    function addplayer(uint playerID,uint PlayerNo, string memory Name, string memory Job, string memory Category,uint Salary, uint Price) public {
        require(msg.sender==TeamOwner, "Only team owner can add the player");
        Player memory player;
        player.playerno = PlayerNo;
        player.name = Name;
        player.job = Job;
        player.category=Category;
        player.salary=Salary;
        player.sold=false;
        player.price=Price;


        playerDetails[playerID]= player;
    }

    function getaPlayer(uint playerID) public payable{
        require (msg.sender != TeamOwner, "Team Owner can not purchase a player");
        Player storage ownerChanged;
        ownerChanged =playerDetails[playerID];
        require(msg.value >= ownerChanged.price,"Not Required amount");
         ownerChanged.sold = true;

    }
    fallback() external payable{}
    receive() external payable{}

}