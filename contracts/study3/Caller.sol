// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Caller{
    address public proxy; // 代理合约地址

    constructor(address proxy_){
        proxy = proxy_;
    }

    // 通过代理合约调用increment()函数
    function increment() external returns(uint) {
        ( , bytes memory data) = proxy.call(abi.encodeWithSignature("getValue()"));
        return abi.decode(data,(uint));
    }
}

contract CallerParam{

      // 通过代理合约调用increment()函数
    function getCallInfo() external returns(bytes4) {
        return bytes4(keccak256("getValue()"));
    }
}