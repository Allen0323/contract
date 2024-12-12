// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
import  "contracts/study2/String.sol";

contract ReloadTest {
    function saySomething() public pure returns (string memory) {
        return ("Nothing");
    }

    function saySomething(string memory something)
        public
        pure
        returns (string memory)
    {
        return (something);
    }

    using Strings for uint256;

    function getString1(uint256 _number) public pure returns (string memory) {
        // 库合约中的函数会自动添加为uint256型变量的成员
        return _number.toHexString();
    }
}
