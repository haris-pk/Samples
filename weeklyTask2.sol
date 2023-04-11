//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract property{

    struct propertyDetails{
        uint propertyno;
        string propertyname;
        string propertydetails;
        address owner;
        uint price;
        bool sold;

    }

    mapping(uint => propertyDetails) public propertySell;
    mapping(uint => propertyDetails) public propertyList;

    address owner;
    propertyDetails[] listofProperty;

    constructor(){
        owner=msg.sender;
    }

    function SellingProperty( uint propertyID, uint PropertyNo, string memory propertyName,string memory PropertyDetails, uint Price) public {
        require(owner==msg.sender, "only owner can sell the property");
        propertyDetails memory record;
        record.propertyno = PropertyNo;
        record.propertyname = propertyName;
        record.propertydetails = PropertyDetails;
        record.price = Price;
        record.sold = false;

        propertySell[propertyID] =record; 
        listofProperty.push(record);


    }

    function buyingproperty(uint propertyID) public payable {
        propertyDetails storage updateRecord;
        updateRecord = propertySell[propertyID];
        require(msg.value >=updateRecord.price,"not required amount" );
        updateRecord.owner =msg.sender;
        updateRecord.sold = true;
  

    }

    pragma solidity ^0.8.0;

contract PayableBankingSystem {
    mapping(address => uint256) private balances;
    address private owner;

    event Transfer(address indexed sender, address indexed recipient, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Unauthorized");
        _;
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public payable {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Transfer(address(this), msg.sender, amount);
    }

    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    function authorizeAccount(address account) public onlyOwner {
        // Implement account authorization code here
    }

    function transfer(address payable recipient, uint256 amount) public payable {
        require(msg.value == amount, "Insufficient funds");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
    }
}
```

    
    fallback() external payable{}
    receive() external payable{}
}