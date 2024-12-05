// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TimeLockedToken is ERC20 {
    uint256 public unlockTime;  // Timestamp after which the tokens can be transferred

    constructor(uint256 initialSupply, uint256 lockTimeInSeconds) ERC20("TimeLockedToken", "TLT") {
        // Mint the initial supply to the deployer's address
        _mint(msg.sender, initialSupply * 10 ** decimals());

        // Set the unlock time
        unlockTime = block.timestamp + lockTimeInSeconds;  // Lock tokens for the specified duration
    }

    // Override the transfer function to enforce the lock
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(block.timestamp >= unlockTime, "Tokens are locked until the unlock time has passed");
        return super.transfer(recipient, amount);
    }

    // Override the transferFrom function to enforce the lock
    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        require(block.timestamp >= unlockTime, "Tokens are locked until the unlock time has passed");
        return super.transferFrom(sender, recipient, amount);
    }
}
