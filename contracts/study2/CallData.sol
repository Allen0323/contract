// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract CallData {
    event Log(bytes data);

    function mint(address to) external {
        emit Log(msg.data);
    }

    function mintSelector() external pure returns (bytes4 mSelector) {
        return bytes4(keccak256("mint(address)"));
    }

    function encodeWithSignature(address x)
        public
        view
        returns (bytes memory result)
    {
        result = abi.encodeWithSignature("mint(address)", x);
    }

    fallback() external payable {}

    function callWithSignature() external {
        // 调用elementaryParamSelector函数
        (bool success1, bytes memory data1) = address(this).call(
            abi.encodeWithSelector(0x6a627842, "0x54f51e51ba5C5d02899eDBb78fcb096C69c7439D")
        );
    }
}
