// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LinearPaymentSplitter {
    // 记录受益人的地址和他们应得的金额
    struct Beneficiary {
        uint256 totalAmount;     // 总应得金额
        uint256 releasedAmount;  // 已释放的金额
        uint256 startTime;       // 开始时间
        uint256 duration;        // 释放周期（以秒为单位）
    }
    
    mapping(address => Beneficiary) public beneficiaries;
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    // 构造函数：初始化合同并设定受益人
    constructor() {
        owner = msg.sender;
    }

    // 添加受益人及其线性释放计划
    function addBeneficiary(address beneficiary, uint256 totalAmount, uint256 startTime, uint256 duration) external onlyOwner {
        require(beneficiaries[beneficiary].totalAmount == 0, "Beneficiary already added");
        
        beneficiaries[beneficiary] = Beneficiary({
            totalAmount: totalAmount,
            releasedAmount: 0,
            startTime: startTime,
            duration: duration
        });
    }

    // 计算当前时间点应该释放给某个受益人的金额
    function release(address beneficiary) external {
        Beneficiary storage ben = beneficiaries[beneficiary];
        require(ben.totalAmount > 0, "Beneficiary not found");

        uint256 timePassed = block.timestamp - ben.startTime; // 计算从开始时间到当前时间的已过去时间
        if (timePassed >= ben.duration) {
            timePassed = ben.duration; // 如果已经超过了释放周期，则释放完所有剩余金额
        }

        uint256 amountToRelease = (ben.totalAmount * timePassed) / ben.duration - ben.releasedAmount;
        require(amountToRelease > 0, "No funds to release");

        ben.releasedAmount += amountToRelease;

        // 转账给受益人
        payable(beneficiary).transfer(amountToRelease);
    }

    // 合约可以接收资金
    receive() external payable {}
}
