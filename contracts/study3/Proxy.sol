// Proxy Contract
pragma solidity ^0.8.0;

interface ILogic {
    function getValue() external view returns (uint256);

    function setValue(uint256 _value) external;
}

contract Proxy {
    uint256 public value;
    event Log(string);
    address implementation;

    constructor(address _implementation) {
        implementation = _implementation;
    }

    fallback() external payable {
        address _impl = implementation;
        require(
            _impl != address(0),
            "Implementation contract address is not set"
        );
        // Delegate call to implementation contract
        (bool success, ) = _impl.delegatecall(msg.data);
        require(success, "Delegatecall failed");
    }
}

// Implementation Contract
pragma solidity ^0.8.0;

contract Logic {
    uint256 public value;
    event Log(string);

    function getValue() public returns (uint256) {
        emit Log("getValue");
        return value;
    }

    function setValue(uint256 _value) external {
        value = _value;
    }
}
