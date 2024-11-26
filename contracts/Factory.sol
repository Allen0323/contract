// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Factory {
    // 用于事件通知，显示新合约地址
    event ContractDeployed(address newContract);

    // 使用 CREATE2 部署合约
    function deploy(bytes memory bytecode, uint256 salt) public returns (address) {
        address newContractAddress;
        // 使用 assembly 来调用 CREATE2
        assembly {
            // 0 是 value, add(bytecode, 0x20) 是 bytecode 地址, mload(bytecode) 是 bytecode 长度, salt 是用户提供的盐
            newContractAddress := create2(0, add(bytecode, 0x20), mload(bytecode), salt)
        }
        
        // 触发事件通知
        emit ContractDeployed(newContractAddress);
        return newContractAddress;
    }
}
