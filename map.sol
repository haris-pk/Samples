// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract depositCurrency{

uint256[] myArray;
     
function deposit(uint256 page, uint256 size) public {
        
        int256 amount;
        uint256[] memory _myArray = myArray;
        uint256 ToSkip = page * size; //to skip
        
        uint256 EndAt = _myArray.length > ToSkip + size ? ToSkip + size : _myArray.length;

        for (uint256 x = ToSkip; x < EndAt; x++) {
            
        }
    }
}

