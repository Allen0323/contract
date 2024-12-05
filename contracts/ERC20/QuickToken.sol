// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import ERC-20 implementation from OpenZeppelin
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Define your token contract
contract MyToken is ERC20 {
    // Constructor to mint an initial supply
    constructor(uint256 initialSupply) ERC20("MyToken", "MTK") {
        // Mint the initial supply to the contract deployer (msg.sender)
        _mint(msg.sender, initialSupply * 10 ** decimals());
    }
}
