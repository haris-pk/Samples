//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract task {
    uint storedData;
        constructor(){}

        function add() public{

            uint i;

            for(i=5; i<=25; i++){
                storedData = storedData + i;
            }

        }

        function Result() public view returns(uint){

            return storedData;
        }



            
}

