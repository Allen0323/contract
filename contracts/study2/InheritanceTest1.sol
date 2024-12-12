// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Yeye {
    event Log(string msg);

    // 定义3个function: hip(), pop(), man()，Log值为Yeye。
    function hip() public virtual {
        emit Log("Yeye");
    }

    function pop() public virtual {
        emit Log("Yeye");
    }

    function yeye() public virtual {
        emit Log("Yeye");
    }
}

contract Baba is Yeye {
    // 继承两个function: hip()和pop()，输出改为Baba。
    function hip() public virtual override {
        emit Log("Baba");
    }

    function pop() public virtual override {
        emit Log("Baba");
    }

    function baba() public virtual {
        emit Log("Baba");
    }
}

contract Erzi is Yeye, Baba {
    // 继承两个function: hip()和pop()，输出值为Erzi。
    function hip() public virtual override(Yeye, Baba) {
        emit Log("Erzi");
    }

    function pop() public virtual override(Yeye, Baba) {
        emit Log("Erzi");
    }

    function callParent() public {
        Yeye.pop();
    }

    function callParentSuper() public {
        // 将调用最近的父合约函数，Baba.pop()
        super.pop();
    }
}

contract Base1 {
    modifier exactDividedBy2And3(uint256 _a) virtual {
        require(_a % 2 == 0 && _a % 3 == 0);
        _;
    }
}

contract Identifier is Base1 {
    //计算一个数分别被2除和被3除的值，但是传入的参数必须是2和3的倍数
    function getExactDividedBy2And3(uint256 _dividend)
        public
        pure
        exactDividedBy2And3(_dividend)
        returns (uint256, uint256)
    {
        return getExactDividedBy2And3WithoutModifier(_dividend);
    }

    //计算一个数分别被2除和被3除的值
    function getExactDividedBy2And3WithoutModifier(uint256 _dividend)
        public
        pure
        returns (uint256, uint256)
    {
        uint256 div2 = _dividend / 2;
        uint256 div3 = _dividend / 3;
        return (div2, div3);
    }

    modifier exactDividedBy2And3(uint256 _a) override {
        _;
        require(_a % 2 == 0);
    }
}
