// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyERC1155Token is ERC1155, Ownable {
    // Token ID mapping (fungible or non-fungible tokens)
    uint256 public constant TOKEN_1 = 1; // A fungible token
    uint256 public constant TOKEN_2 = 2; // Another fungible token
    uint256 public constant NFT_1 = 100; // A non-fungible token

    constructor()
        ERC1155("https://myapi.com/api/token/{id}.json")
        Ownable(msg.sender)
    {}

    // Mint function: Mint fungible or non-fungible tokens to an address
    function mint(
        address account,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public onlyOwner {
        _mint(account, id, amount, data);
    }

    // Mint multiple tokens (batch minting)
    function mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public onlyOwner {
        _mintBatch(to, ids, amounts, data);
    }

    // Burn tokens (destroy them)
    function burn(
        address account,
        uint256 id,
        uint256 amount
    ) public onlyOwner {
        _burn(account, id, amount);
    }

    // Burn multiple tokens (batch burn)
    function burnBatch(
        address account,
        uint256[] memory ids,
        uint256[] memory amounts
    ) public onlyOwner {
        _burnBatch(account, ids, amounts);
    }

    // Function to query the balance of a specific token for an address
    function balanceOf(address account, uint256 id)
        public
        view
        override
        returns (uint256)
    {
        return super.balanceOf(account, id);
    }

    // Function to query the balance of multiple tokens for an address
    function balanceOfBatch(address[] memory accounts, uint256[] memory ids)
        public
        view
        override
        returns (uint256[] memory)
    {
        return super.balanceOfBatch(accounts, ids);
    }

    // Custom function to set a URI for metadata
    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }
}
