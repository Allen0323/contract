// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract HelloWeb {
    bytes32 public _byte32 = "MiniSolidity";
    bytes1 public _byte = _byte32[1];
    string public _string = "Hello Web3!";
    enum ActionSet {
        Buy,
        Hold,
        Sell
    }
    // 创建enum变量 action
    ActionSet action = ActionSet.Hold;

    function enumToUint() external view returns (uint256) {
        return uint256(action);
    }

    uint256 public number = 5;

    function add() external {
        number = number + 1;
    }

    function addPure(uint256 _number)
        external
        pure
        returns (uint256 new_number)
    {
        new_number = _number + 1;
    }

    function addView() external view returns (uint256 new_number) {
        new_number = number + 1;
    }

    function minus() internal {
        number = number - 1;
    }

    // 合约内的函数可以调用内部函数
    function minusCall() external {
        minus();
    }

    function minusPayable() external payable returns (uint256 balance) {
        minus();
        balance = address(this).balance;
    }

    function returnMultiple()
        public
        pure
        returns (
            uint256,
            bool,
            uint256[3] memory
        )
    {
        return (1, true, [uint256(1), 2, 5]);
    }

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

    function redReturn(uint256 i) public pure returns (uint256 t1, bool t2) {
        uint256 _number = 1;
        bool _bool;
        uint256[3] memory _array;
        if (i == 1) {
            (, _bool, _array) = returnNamed();
        } else {
            (_number, _bool, _array) = returnNamed();
        }

        t1 = _number;
        t2 = _bool;
    }
}
