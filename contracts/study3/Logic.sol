// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Logic1 {
    address private implementation;
    uint256 public value;

    // Set value in the logic contract
    function setValue(uint256 _value) external {
        value = _value;
    }

    // Get value from the logic contract
    function getValue() external view returns (uint256) {
        return value;
    }

    fallback() external payable {}
}

contract Logic2 {
    uint256 public value;

    // Set value in the logic contract
    function setValue(uint256 _value) external {
        value = _value;
    }

    // Get value from the logic contract
    function getValue() external view returns (uint256) {
        return value + 1;
    }

    fallback() external payable {}
}
