// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Storage {
    uint256[] public x = [1, 2, 3];

    function fCalldata(uint256[] calldata _x)
        public
        pure
        returns (uint256[] calldata)
    {
        //参数为calldata数组，不能被修改
        // _x[0] = 0 //这样修改会报错
        return (_x);
    }

    function fStorage() public {
        //声明一个storage的变量 xStorage，指向x。修改xStorage也会影响x
        uint256[] storage xStorage = x;
        xStorage[0] = 100;
    }

    function global()
        external
        view
        returns (
            address,
            uint256,
            bytes memory
        )
    {
        address sender = msg.sender;
        uint256 blockNum = block.number;
        bytes memory data = msg.data;
        return (sender, blockNum, data);
    }

    function weiUnit() external pure returns (uint256) {
        assert(1 wei == 1e0);
        assert(1 wei == 1);
        return 1 wei;
    }

    function gweiUnit() external pure returns (uint256) {
        assert(1 gwei == 1e9);
        assert(1 gwei == 1000000000);
        return 1 gwei;
    }

    function etherUnit() external pure returns (uint256) {
        assert(1 ether == 1e18);
        assert(1 ether == 1000000000000000000);
        return 1 ether;
    }

    function weeksUnit() external pure returns (uint256) {
        assert(1 weeks == 604800);
        assert(1 weeks == 7 days);
        return 1 weeks;
    }

    function f() public pure {
        g([uint256(1), 2, 3]);
    }

    function g(uint256[3] memory _data)
        public
        pure
        returns (uint256[3] memory data1)
    {
        data1 = _data;
        // ...
    }
}
