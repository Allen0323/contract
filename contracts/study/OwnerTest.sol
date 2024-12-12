// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract MyContract is Ownable {
    string public data;

    constructor() Ownable(msg.sender) {}

    // Function only callable by the owner
    function setData(string memory _data) public onlyOwner {
        data = _data;
    }

    // Function to transfer ownership
    function transferOwnership(address newOwner) public override onlyOwner {
        super.transferOwnership(newOwner);
    }
}
