// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract EventTest {
    mapping(address => uint256) public _balances;
    event Transfer(address indexed from, address indexed to, uint256 value);
    bytes32 public btest;

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) external {
        _balances[from] = 10000000; // 给转账地址一些初始代币

        _balances[from] -= amount; // from地址减去转账数量
        _balances[to] += amount; // to地址加上转账数量

        btest = keccak256("Transfer(address,address,uint256)");
        // 释放事件
        emit Transfer(from, to, amount);
    }
}
