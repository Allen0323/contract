// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract traferETH {
    constructor() payable {}

    // receive方法，接收eth时被触发
    receive() external payable {}

    // 用transfer()发送ETH
    function transferETH(address payable _to, uint256 amount) external payable {
        _to.transfer(amount);
    }
}

contract sendEth2 {
    error SendFailed(); // 用send发送ETH失败error

    receive() external payable {}

    // send()发送ETH
    function sendETH(address payable _to, uint256 amount) external payable {
        // 处理下send的返回值，如果失败，revert交易并发送error
        bool success = _to.send(amount);
        if (!success) {
            revert SendFailed();
        }
    }
}

contract callEth {
    error CallFailed(); // 用call发送ETH失败error

    receive() external payable {}

    // call()发送ETH
    function callETH(address payable _to, uint256 amount) external payable {
        // 处理下call的返回值，如果失败，revert交易并发送error
        (bool success, ) = _to.call{value: amount}("");
        if (!success) {
            revert CallFailed();
        }
    }
}
