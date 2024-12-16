// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Airdrop is Ownable {
    IERC20 public token; // ERC-20 token used for the airdrop

    // Constructor to initialize token address
    constructor(address _token) Ownable(msg.sender) {
        token = IERC20(_token);
    }

    // Function to distribute tokens to multiple addresses
    function distributeTokens(address[] calldata recipients, uint256 amount)
        external
        onlyOwner
    {
        require(recipients.length > 0, "No recipients");
        require(amount > 0, "Amount must be greater than 0");

        // Loop through all recipients and transfer tokens
        for (uint256 i = 0; i < recipients.length; i++) {
            require(
                token.balanceOf(address(this)) >= amount,
                "Insufficient balance in contract"
            );
            token.transfer(recipients[i], amount);
        }
    }

    // Admin function to withdraw tokens in case of errors
    function withdrawTokens(uint256 amount) external onlyOwner {
        require(
            token.balanceOf(address(this)) >= amount,
            "Insufficient contract balance"
        );
        token.transfer(owner(), amount);
    }
}
