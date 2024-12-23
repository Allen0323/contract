// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract LPLock {
    address public owner; // 锁仓合约的拥有者
    IERC20 public lpToken; // LP代币的地址
    uint256 public unlockTime; // 解锁时间戳
    address public beneficiary; // 流动性提供者的地址

    // 事件：记录LP代币被锁仓
    event Locked(address indexed beneficiary, uint256 amount, uint256 unlockTime);
    // 事件：记录LP代币解锁
    event Unlocked(address indexed beneficiary, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    modifier onlyAfterUnlock() {
        require(block.timestamp >= unlockTime, "Tokens are locked");
        _;
    }

    constructor(IERC20 _lpToken, uint256 _unlockDuration) {
        owner = msg.sender; // 合约部署者为拥有者
        lpToken = _lpToken; // 设置LP代币的地址
        unlockTime = block.timestamp + _unlockDuration; // 设置解锁时间（单位：秒）
    }

    // 锁仓LP代币
    function lock(uint256 amount) external {
        require(amount > 0, "Amount should be greater than 0");
        require(lpToken.transferFrom(msg.sender, address(this), amount), "Transfer failed");

        beneficiary = msg.sender; // 锁仓者是LP代币的持有者
        emit Locked(msg.sender, amount, unlockTime);
    }

    // 解锁LP代币
    function unlock() external onlyAfterUnlock {
        require(msg.sender == beneficiary, "Not the beneficiary");
        uint256 balance = lpToken.balanceOf(address(this));
        require(balance > 0, "No LP tokens to unlock");

        // 转回LP代币到受益人地址
        require(lpToken.transfer(beneficiary, balance), "Transfer failed");
        emit Unlocked(beneficiary, balance);
    }

    // 如果需要，合约拥有者可以提前收回未解锁的代币
    function recoverTokens() external onlyOwner {
        uint256 balance = lpToken.balanceOf(address(this));
        require(balance > 0, "No tokens to recover");
        require(lpToken.transfer(owner, balance), "Transfer failed");
    }
}
