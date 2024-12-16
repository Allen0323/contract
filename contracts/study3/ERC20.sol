// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import the ERC20 contract from OpenZeppelin
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Your token contract inherits from ERC20
contract MyToken is ERC20 {
    // Constructor to initialize the token with a name and symbol
    constructor(uint256 initialSupply,string memory name ,string memory symbol) ERC20(name, symbol) {
        // Mint initial supply to the deployer's address
        _mint(msg.sender, initialSupply * 10 ** decimals());
    }
}
