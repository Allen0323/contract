// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Constructor {
    address owner; // 定义owner变量

    // 构造函数
    constructor(address initialOwner) {
        owner = initialOwner; // 在部署合约的时候，将owner设置为传入的initialOwner地址
    }

    // 定义modifier
    modifier onlyOwnerTest() {
        require(msg.sender == owner); // 检查调用者是否为owner地址
        _; // 如果是的话，继续运行函数主体；否则报错并revert交易
    }

    function changeOwner(address _newOwner) external onlyOwnerTest {
        owner = _newOwner; // 只有owner地址运行这个函数，并改变owner
    }

    string public myData;

    // Only the owner can call this function
    function setMyData(string memory newData) public onlyOwnerTest {
        myData = newData;
    }
}
