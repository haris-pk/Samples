//SPDX-License-Identifier:MIT
pragma solidity ^0.8.7;

contract transferErc20{

    mapping(address => uint)public balance;
    function transfer(address to, uint amount) public{
        balance[msg.sender] -= amount;
        balance[to] += amount;
    }

}
interface check{
     function transfer(address to, uint amount) external;
}

contract getData{
    constructor(address contractAddress){
        contractUserAddress=contractAddress;
    }
    address public contractUserAddress;

    function transfer(address to, uint amount) public{
        return check(contractUserAddress).transfer(to,amount);
    }
}

