//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Data{

    struct Book{
        string title;
        string author;
        uint book_id;
    }

    mapping(uint => Book) public BookRecord;

    function checkbook(uint256 checkID, string memory Title, string memory Author, uint ID)  public {
        
        Book memory book;
        book.title = Title;
        book.author = Author;
        book.book_id = ID;

        BookRecord[checkID] = book;
    }
}