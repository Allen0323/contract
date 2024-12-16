// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Faucet {
    IERC20 public token;  // The ERC20 token used by the faucet
    uint256 public amount = 1 * 10 ** 18; // 1 Token (Assuming 18 decimals)

    // Constructor to initialize the token address
    constructor(address _token) {
        token = IERC20(_token);
    }

    // Function to request tokens
    function requestTokens() external {
        require(token.balanceOf(address(this)) >= amount, "Insufficient tokens in faucet");
        token.transfer(msg.sender, amount);  // Send tokens to the user
    }

    // Admin function to refill faucet
    function refill(uint256 _amount) external {
        token.transferFrom(msg.sender, address(this), _amount);  // Transfer tokens into the faucet
    }
}
