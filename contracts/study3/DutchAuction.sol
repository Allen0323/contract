// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DutchAuction {
    // 定义变量
    address public seller;
    uint256 public initialPrice; // 初始价格
    uint256 public finalPrice; // 最低价格（结束时的价格）
    uint256 public priceDecrement; // 每次价格递减的幅度
    uint256 public auctionStartTime; // 拍卖开始时间
    uint256 public auctionDuration; // 拍卖持续时间（秒）
    uint256 public auctionEndTime; // 拍卖结束时间
    bool public auctionEnded = false;
    uint256 public money;

    // 记录买家地址
    address public buyer;

    // 事件定义
    event ItemPurchased(address indexed buyer, uint256 price);
    event AuctionEnded(address indexed winner, uint256 finalPrice);

    // 构造函数：初始化拍卖参数
    constructor(
        uint256 _initialPrice,
        uint256 _finalPrice,
        uint256 _priceDecrement,
        uint256 _auctionDuration
    ) payable {
        seller = msg.sender;
        initialPrice = _initialPrice;
        finalPrice = _finalPrice;
        priceDecrement = _priceDecrement;
        auctionDuration = _auctionDuration;
        auctionStartTime = block.timestamp;
        auctionEndTime = auctionStartTime + _auctionDuration;
        money = msg.value;
    }

    receive() external payable {
        money = msg.value;
    }

    // 计算当前价格
    function getCurrentPrice() public view returns (uint256) {
        // 计算已过去的时间
        uint256 timeElapsed = block.timestamp - auctionStartTime;

        // 如果拍卖已结束，则返回最低价格
        if (block.timestamp >= auctionEndTime || auctionEnded) {
            return finalPrice;
        }

        // 计算当前价格：每秒下降价格
        uint256 priceReduction = timeElapsed * priceDecrement;
        uint256 currentPrice = initialPrice - priceReduction;

        // 确保价格不低于最终价格
        if (currentPrice < finalPrice) {
            return finalPrice;
        }

        return currentPrice;
    }

    // 买家购买商品
    function purchaseItem() external payable {
        require(
            block.timestamp >= auctionStartTime,
            "Auction hasn't started yet."
        );
        require(
            block.timestamp <= auctionEndTime,
            "Auction has already ended."
        );
        require(money >= getCurrentPrice(), "Insufficient funds to purchase.");
        require(!auctionEnded, "Auction has already ended.");

        // 记录买家
        buyer = msg.sender;
        auctionEnded = true;

        // 将购买金额转给卖家
        payable(seller).transfer(msg.value);

        emit ItemPurchased(buyer, msg.value);
        emit AuctionEnded(buyer, getCurrentPrice());
    }

    // 允许卖家取消拍卖（可选）
    function cancelAuction() external {
        require(msg.sender == seller, "Only seller can cancel the auction.");
        require(!auctionEnded, "Auction has already ended.");
        auctionEnded = true;
    }

    // 返回当前时间戳
    function getCurrentTime() external view returns (uint256) {
        return block.timestamp;
    }
}
