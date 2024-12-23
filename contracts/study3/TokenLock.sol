// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenLock {
    IERC20 public token;
    address public beneficiary;
    uint256 public unlockTime;
    
    event Locked(address indexed beneficiary, uint256 amount, uint256 unlockTime);
    event Unlocked(address indexed beneficiary, uint256 amount);
    
    // Mapping to track locked tokens for each address
    mapping(address => uint256) public lockedTokens;
    
    modifier onlyBeneficiary() {
        require(msg.sender == beneficiary, "Only beneficiary can call this function.");
        _;
    }
    
    modifier isUnlocked() {
        require(block.timestamp >= unlockTime, "Tokens are still locked.");
        _;
    }

    constructor(IERC20 _token, address _beneficiary, uint256 _unlockTime) {
        require(_unlockTime > block.timestamp, "Unlock time must be in the future.");
        token = _token;
        beneficiary = _beneficiary;
        unlockTime = _unlockTime;
    }
    
    function lockTokens(uint256 amount) external onlyBeneficiary {
        require(amount > 0, "Amount must be greater than zero.");
        require(token.balanceOf(msg.sender) >= amount, "Insufficient balance.");
        
        // Transfer the tokens from the beneficiary to the contract
        require(token.transfer(address(this), amount), "Token transfer failed.");
        
        // Track the locked tokens
        lockedTokens[msg.sender] += amount;
        
        emit Locked(msg.sender, amount, unlockTime);
    }

    function unlockTokens() external onlyBeneficiary isUnlocked {
        uint256 amount = lockedTokens[msg.sender];
        require(amount > 0, "No locked tokens to unlock.");
        
        // Reset the locked tokens for the user
        lockedTokens[msg.sender] = 0;
        
        // Transfer the unlocked tokens back to the beneficiary
        require(token.transfer(msg.sender, amount), "Token transfer failed.");
        
        emit Unlocked(msg.sender, amount);
    }
}
