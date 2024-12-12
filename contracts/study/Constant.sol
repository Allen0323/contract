// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Constant {
    uint256 constant CONSTANT_NUM = 10;
    string constant CONSTANT_STRING = "0xAA";
    bytes constant CONSTANT_BYTES = "WTF";
    address constant CONSTANT_ADDRESS =
        0x0000000000000000000000000000000000000000;

    uint256 public immutable IMMUTABLE_NUM = 9999999999;
    address public immutable IMMUTABLE_ADDRESS;
    uint256 public immutable IMMUTABLE_BLOCK;
    uint256 public immutable IMMUTABLE_TEST;

    constructor() {
        IMMUTABLE_ADDRESS = address(this);
        IMMUTABLE_NUM = 1118;
        IMMUTABLE_TEST = test();
    }

    function test() public pure returns (uint256) {
        uint256 what = 9;
        return (what);
    }

    function ifElseTest(uint256 _number) public pure returns (bool) {
        if (_number == 0) {
            return (true);
        } else {
            return (false);
        }
    }

    function forLoopTest() public pure returns (uint256) {
        uint256 sum = 0;
        for (uint256 i = 0; i < 10; i++) {
            sum += i;
        }
        return (sum);
    }

    function whileTest() public pure returns (uint256) {
        uint256 sum = 0;
        uint256 i = 0;
        while (i < 10) {
            sum += i;
            i++;
        }
        return (sum);
    }

    function doWhileTest() public pure returns (uint256) {
        uint256 sum = 0;
        uint256 i = 0;
        do {
            sum += i;
            i++;
        } while (i < 10);
        return (sum);
    }

    function ternaryTest(uint256 x, uint256 y) public pure returns (uint256) {
        // return the max of x and y
        return x >= y ? x : y;
    }

    function insertionSort(uint256[] memory a)
        public
        pure
        returns (uint256[] memory)
    {
        // note that uint can not take negative value
        for (uint256 i = 1; i < a.length; i++) {
            uint256 temp = a[i];
            uint256 j = i;
            while ((j >= 1) && (temp < a[j - 1])) {
                a[j] = a[j - 1];
                j--;
            }
            a[j] = temp;
        }
        return (a);
    }
}
