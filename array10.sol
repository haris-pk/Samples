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
