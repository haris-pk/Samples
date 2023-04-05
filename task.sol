//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract task{

    funtion getResult() public view returns(uint product, uint sum){
        uint a=1;
        uint b-2;
        product = a*b;
        sum = a + b;
    }


}

 function propertyToBuy(uint ID) public payable{
        sellProperty memory _sellProperty;
        _sellProperty = propertyForSell[ID];
        address currenOwner = _sellProperty.Owner;
        uint256 _amount = _sellProperty.propertyprice;
        IERC20(tokenAddress).transferFrom(msg.sender, currenOwner, _amount);
        _sellProperty.Owner =msg.sender;
        _sellProperty.sold = true;
    }  
    
}