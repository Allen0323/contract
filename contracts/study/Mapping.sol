// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract MappingTest {
    mapping(address => address) public testAddress;
    mapping(uint256 => address) public testUnit;

    function writeMap(address key, address value) public {
        testAddress[key] = value;
    }
}
