// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./ERC721Test.sol";
import "./MerkleProof.sol";

contract MerkleTree is ERC721TEST {
    bytes32 public immutable root; // Merkle树的根
    mapping(address => bool) public mintedAddress; // 记录已经mint的地址
    string url = "https://baiddu.com";

    // 构造函数，初始化NFT合集的名称、代号、Merkle树的根
    constructor(
        string memory name,
        string memory symbol,
        bytes32 merkleroot
    ) ERC721TEST(name, symbol, url) {
        root = merkleroot;
    }

    // 利用Merkle树验证地址并完成mint
    function mint(
        address account,
        uint256 tokenId,
        bytes32[] calldata proof
    ) external {
        require(_verify(_leaf(account), proof), "Invalid merkle proof"); // Merkle检验通过
        require(!mintedAddress[account], "Already minted!"); // 地址没有mint过
        _mint(account, tokenId); // mint
        mintedAddress[account] = true; // 记录mint过的地址
    }

    // 计算Merkle树叶子的哈希值
    function _leaf(address account) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(account));
    }

    // Merkle树验证，调用MerkleProof库的verify()函数
    function _verify(bytes32 leaf, bytes32[] memory proof)
        internal
        view
        returns (bool)
    {
        return MerkleProof.verify(proof, root, leaf);
    }
}
