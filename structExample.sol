//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Data{

    struct Book{
        string title;
        string author;
        uint id;
    }

    mapping(uint => Book) public BookRecord;

    modifier myCondition(uint ID) {
        require(ID != 5, "ID is not matched");
        _;
    }

    function checkbook(uint256 checkID, string memory Title, string memory Author, uint ID) public myCondition(ID) {
        Book memory book;
        book.title=Title;
        book.author=Author;
        book.id=ID;
        //require(ID != 5, "ID is not matched");
        BookRecord[checkID] = book;
    }

}