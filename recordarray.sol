//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract dataStorage{

      uint[] dataShow;
    

    function arraydata( uint anynumber) public {

        dataShow.push(anynumber);
    }

    function getResult() public view returns(uint256[] memory){
                     return dataShow;

        }
    

   function addArray() public {
        for(uint x=0; x < dataShow.length; x++){
            dataShow[x] += 6;
        }
    } 
}
    
