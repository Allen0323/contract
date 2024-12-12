// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract FallBack {
    event Received(address Sender, uint256 Value);

    // 接收ETH时释放Received事件
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

    event fallbackCalled(address Sender, uint256 Value, bytes Data);

    // fallback
    fallback() external payable {
        emit fallbackCalled(msg.sender, msg.value, msg.data);
    }

     // 返回合约ETH余额
    function getBalance() view public returns(uint) {
        return address(this).balance;
    }
}
