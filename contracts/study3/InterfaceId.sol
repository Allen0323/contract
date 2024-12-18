// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./ERC721Test.sol";

contract InterfaceIdTest {
    bytes4 public constant INTERFACE_ID_ERC20 = type(IERC721).interfaceId;

    function getInterfaceId() external pure returns (bytes4) {
        return INTERFACE_ID_ERC20;
    }

    function checkContract(address _Address) external view returns (bool) {
        ERC721TEST oc = ERC721TEST(_Address);
        bool supportsERC721 = oc.supportsInterface(INTERFACE_ID_ERC20);
        return supportsERC721;
    }
}
