// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract HelloWeb {
    uint256 public number = 5;

    //add 合約變量
    function add() external {
        number = number + 1;
    }

    //view 只能讀取合約變量 不能修改
    function addView(uint256 _number) public view returns (uint256 new_number) {
        new_number = _number + 1;
    }

    function returnNamed2()
        public
        pure
        returns (
            uint256 _number,
            bool _bool,
            uint256[3] memory _array
        )
    {
        return (11, true, [uint256(7), uint256(8), uint256(8)]);
    }

    // 命名式返回
    function returnNamed()
        public
        pure
        returns (
            uint256 _number,
            bool _bool,
            uint256[3] memory _array
        )
    {
        _number = 2;
        _bool = false;
        _array = [uint256(3), 2, 1];
    }

    function returnValue()
        public
        pure
        returns (
            uint256 _number2,
            bool _bool2,
            uint256[3] memory _array
        )
    {
        //view
        (_number2, _bool2, _array) = returnNamed();
    }
}
