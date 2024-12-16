// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
import "contracts/study2/String.sol";

contract OtherContract {
    uint256 private _x = 0; // 状态变量x
    // 收到eth的事件，记录amount和gas
    event Log(uint256 amount, uint256 gas);

    fallback() external payable {}

    // 返回合约ETH余额
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // 可以调整状态变量_x的函数，并且可以往合约转ETH (payable)
    function setX(uint256 x) external payable {
        _x = x;
        // 如果转入ETH，则释放Log事件
        if (msg.value > 0) {
            emit Log(msg.value, gasleft());
        }
    }

    // 读取x
    function getX() external view returns (uint256 x) {
        x = _x;
    }
}

contract CallContract {
    event Response(bool success, bytes data);

    receive() external payable { }

    function callSetX(address payable _addr, uint256 x) public payable {
        // call setX()，同时可以发送ETH
        (bool success, bytes memory data) = _addr.call{value: msg.value}(
            abi.encodeWithSignature("setX(uint256)", x)
        );

        emit Response(success, data); //释放事件
    }

   function callSetX2(address payable _addr, uint256 x) public payable {
        // call setX()，同时可以发送ETH
        (bool success, bytes memory data) = _addr.call{value: x}(
            abi.encodeWithSignature("setX(uint256)", x)
        );

        emit Response(success, data); //释放事件
    }


    function getXSample1(OtherContract addr) external returns (uint256 _x) {
        _x = addr.getX();
    }

    function callGetX(address _addr) external returns (uint256) {
        // call getX()
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("getX()")
        );

        emit Response(success, data); //释放事件
        return abi.decode(data, (uint256));
    }
}
