// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

// 被调用的合约C
contract C {
    uint256 public num;
    address public sender;

    event Log(address addr);

    function setVars(uint256 _num) public payable {
        num = _num;
        sender = msg.sender;
        emit Log(msg.sender);
    }
}

contract B {
    uint256 public num;
    address public sender;

    function callSetVars(address _addr, uint256 _num) external payable {
        // call setVars()
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
    }

    // 通过delegatecall来调用C的setVars()函数，将改变合约B里的状态变量
    function delegatecallSetVars(address _addr, uint256 _num) external payable {
        // delegatecall setVars()
        (bool success, bytes memory data) = _addr.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
        assert(success == true);
    }
}
