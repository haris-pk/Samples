// SPDX-License-Identifier:MIT
pragma solidity ^0.8.7;

interface IERC20{
    function totalsupply() external view returns(uint);
    function _mint(address _userAddress, uint256 _amount) external;
    function balanceof(address checkbalance) external view returns(uint);
    function transfer(address to, uint amount) external;
    function transferfrom(address from, address to, uint amount) external;
    function approve(address spender, uint amount) external;

}