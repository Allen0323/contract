// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import the OpenZeppelin ERC721 standard implementation
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ERC721TEST is ERC721, Ownable {
    uint256 public nextTokenId;
    // A base URI for the metadata (e.g., IPFS, or any URI where you store your metadata)
    string private _baseTokenURI;

    constructor(
        string memory name,
        string memory symbol,
        string memory baseURI
    ) ERC721(name, symbol) Ownable(msg.sender) {
        _baseTokenURI = baseURI; // Set the base URI for metadata
        nextTokenId = 1; // Start token IDs from 1
    }

    // Override the _baseURI function to return the base URI for metadata
    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    // Function to mint a new token
    function mint(address to) external onlyOwner {
        _safeMint(to, nextTokenId); // Mint a new token with nextTokenId
        nextTokenId++; // Increment token ID for the next mint
    }

    // Function to set a new base URI (onlyOwner can update it)
    function setBaseURI(string memory baseURI) external onlyOwner {
        _baseTokenURI = baseURI;
    }
}
