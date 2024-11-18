// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

// Gas cost在Remix中测试得到 使用0.8.17版本编译
// 参数使用 tokenId = 123, address = {any address}

// 自定义error
error TransferNotOwner(string msg);

// error TransferNotOwner(address sender);

contract Errors {
    // 一组映射，记录每个TokenId的Owner
    mapping(uint256 => address) private _owners;
    // event Log(uint test);
    event Log(address address1);

    function setOwner(uint256 tokenId, address address1) public {
        emit Log(msg.sender);
        _owners[tokenId] = address1;
    }

    // Error方法: gas cost 24457
    // Error with parameter: gas cost 24660
    function transferOwner1(uint256 tokenId, address newOwner) public {
        if (_owners[tokenId] == msg.sender) {
            revert TransferNotOwner("Transfer Not Owner test");
            // revert TransferNotOwner(msg.sender);
        }
        _owners[tokenId] = newOwner;
    }

    // require方法: gas cost 24755
    function transferOwner2(uint256 tokenId, address newOwner) public {
        require(_owners[tokenId] == msg.sender, "Transfer Not Owner");
        _owners[tokenId] = newOwner;
    }

    // assert方法: gas cost 24473
    function transferOwner3(uint256 tokenId, address newOwner) public {
        assert(_owners[tokenId] == msg.sender);
        _owners[tokenId] = newOwner;
    }

    function f(uint8 _in) public pure returns (uint8 out) {
        out = _in;
    }

    function f(string memory _in) public pure returns (string memory out) {
        out = _in;
    }
}
