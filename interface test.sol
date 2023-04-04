//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ERC20{

    uint totalsupply;
    constructor() {
        mint(msg.sender,1000000000 *10 **18 );
    }

    mapping(address => uint)public balance;
    mapping(address => mapping(address => uint)) public allowence; 

    function total_supply() public view returns(uint){
          return totalsupply;
      }

    function mint(address useraddress, uint amount)public{
            balance[useraddress] = amount;
    }

    function balanceof(address checkbalance) public view returns(uint){
        return balance[checkbalance]; 

    }

    function transfer(address to, uint amount) public{
        balance[msg.sender] -= amount;
        balance[to] += amount;
    }

    function transferfrom(address from,address to,uint amount) public{
        require(amount < allowence[from][msg.sender], "not allowed" );
        balance[from] -= amount;
        balance[to] += amount;
        allowence[from][msg.sender] -= amount;
    }
    function approve(address spender,uint amount) public{
           allowence[msg.sender][spender] +=amount;
    }

} 

interface IERC20{
    function total_supply() external view returns(uint);
    function balanceof(address checkbalance) external view returns(uint);
    function transfer(address to, uint amount) external;
    function transferfrom(address from,address to,uint amount)external;
    function approve(address spender,uint amount) external;

}
contract getERC20{

    constructor(address contractAddress){
        contractUserAddress=contractAddress;
    }
    address public contractUserAddress;

      function getTotalSupply() public view returns(uint){
          return IERC20(contractUserAddress).total_supply(); 
      }
      function balanceof(address checkbalance) public view returns(uint){
         return IERC20(contractUserAddress).balanceof(checkbalance);
     }
      function transfer(address to, uint amount) public{
        return IERC20(contractUserAddress).transfer(to,amount);
    }
      function transferfrom(address from,address to,uint amount)public{
        return IERC20(contractUserAddress).transferfrom(from,to,amount);
    }

}




