// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";



contract MyNFT is ERC721URIStorage, Ownable{

    constructor() ERC721("SharksPk", "SK"){}

    function mint(address to,uint tokenId,string calldata uri) external onlyOwner{
        _mint(to,tokenId);
        _setTokenURI(tokenId, uri);
        
    }



    }

        