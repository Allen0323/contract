// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract TryCatchTest {
    // 成功event
    event SuccessEvent();

    // 失败event
    event CatchEvent(string message);
    event CatchByte(bytes data);

    // 声明OnlyEven合约变量
    OnlyEven even;

    constructor() {
        even = new OnlyEven(2);
    }

    // 在external call中使用try-catch
    function execute(uint256 amount) external returns (bool success) {
        try even.onlyEven(amount) returns (bool _success) {
            // call成功的情况下
            emit SuccessEvent();
            return _success;
        } catch Error(string memory reason) {
            // call不成功的情况下
            emit CatchEvent(reason);
        }
    }
}

contract OnlyEven {
    constructor(uint256 a) {
        require(a != 0, "invalid number");
        assert(a != 1);
    }

    function onlyEven(uint256 b) external pure returns (bool success) {
        // 输入奇数时revert
        require(b % 2 == 0, "Ups! Reverting");
        success = true;
    }
}
