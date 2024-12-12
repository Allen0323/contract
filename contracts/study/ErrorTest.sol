// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract ErrorTest {
    error TransferNotOwner(address sender); // 自定义的带参数的error
    mapping(uint256 => address) private _owners;

    constructor(uint256 tokenId) {
        _owners[tokenId] = msg.sender;
    }

    function transferOwner1(uint256 tokenId, address newOwner) public {
        if (_owners[tokenId] != msg.sender) {
            revert TransferNotOwner(newOwner);
            // revert TransferNotOwner(msg.sender);
        }
        _owners[tokenId] = newOwner;
    }

    function transferOwner2(uint256 tokenId, address newOwner) public {
        require(_owners[tokenId] == msg.sender, "Transfer Not Owner");
        _owners[tokenId] = newOwner;
    }

    function transferOwner3(uint256 tokenId, address newOwner) public {
        assert(_owners[tokenId] == msg.sender);
        _owners[tokenId] = newOwner;
    }
}
