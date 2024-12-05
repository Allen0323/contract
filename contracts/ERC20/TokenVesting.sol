// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LinearVesting {
    address public beneficiary;  // 受益人地址
    uint256 public startTime;    // 释放开始时间
    uint256 public endTime;      // 释放结束时间
    uint256 public totalAmount;  // 总金额（代币数量）
    uint256 public released;     // 已释放的代币数量

    // 事件，用于通知释放情况
    event TokensReleased(uint256 amount);

    constructor(address _beneficiary, uint256 _totalAmount, uint256 _startTime, uint256 _endTime) {
        require(_beneficiary != address(0), "Invalid beneficiary address");
        require(_endTime > _startTime, "End time must be greater than start time");
        require(_totalAmount > 0, "Total amount must be greater than zero");

        beneficiary = _beneficiary;
        totalAmount = _totalAmount;
        startTime = _startTime;
        endTime = _endTime;
        released = 0;
    }

    // 计算在当前时间点已经释放的代币数量
    function getVestedAmount() public view returns (uint256) {
        if (block.timestamp <= startTime) {
            return 0;
        } else if (block.timestamp >= endTime) {
            return totalAmount;
        } else {
            uint256 durationElapsed = block.timestamp - startTime;
            uint256 totalDuration = endTime - startTime;
            return (totalAmount * durationElapsed) / totalDuration;
        }
    }

    // 释放代币
    function release() public {
        require(msg.sender == beneficiary, "Only the beneficiary can release tokens");
        uint256 vested = getVestedAmount();
        uint256 releasable = vested - released;

        require(releasable > 0, "No tokens available for release");

        released = vested;
        emit TokensReleased(releasable);

        // 在这里可以实际转移代币，比如 ERC20 的 `transfer` 函数
        // ERC20(tokenAddress).transfer(beneficiary, releasable);
    }

    // 查看剩余未释放的代币数量
    function remaining() public view returns (uint256) {
        return totalAmount - released;
    }
}
