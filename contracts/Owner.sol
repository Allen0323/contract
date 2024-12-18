// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Owner {
    address public owner; // 定义owner变量
    event Log(string);
    event Log(address);

    // 构造函数
    constructor(address initialOwner) {
        owner = initialOwner; // 在部署合约的时候，将owner设置为传入的initialOwner地址
    }

    // 定义modifier
    modifier onlyOwner() {
        emit Log(msg.sender);
        emit Log(owner);
        require(msg.sender==owner);
        _; // 如果是的话，继续运行函数主体；否则报错并revert交易
    }

    // 定义一个带onlyOwner修饰符的函数
    function changeOwner2(address _newOwner) external onlyOwner {
        owner = _newOwner; // 只有owner地址运行这个函数，并改变owner
    }
}
