// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract msgTestContract{
    address public tAddress;
    uint256 public money;
    address public zAddress;

        constructor() payable {
            tAddress=msg.sender;
            money=msg.value;
            zAddress=address(this);
        }
}