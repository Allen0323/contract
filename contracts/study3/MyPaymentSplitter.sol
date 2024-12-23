// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/finance/PaymentSplitter.sol";

contract MyPaymentSplitter is PaymentSplitter {
    // Constructor accepts an array of payees and corresponding shares
    constructor(address[] memory payees, uint256[] memory shares) 
        PaymentSplitter(payees, shares) 
    {}
}
