// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Challenge08 is ERC1155, Ownable {

    uint8 public constant MAX_NFTS = 10;

    mapping(address user => uint256 amount) balance;

    constructor() ERC1155("") Ownable(msg.sender) {}

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function mint(address account, uint256 id, uint256 amount, bytes memory data)
        public
    {
        require(balance[account] + amount <= MAX_NFTS, "Not allowed!");
        balance[account] += amount;
        _mint(account, id, amount, data);
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
    {
        uint256 total = 0;
        for(uint256 i = 0; i < amounts.length; i++) {
            total += amounts[i];
        }
        require(balance[to] + total <= MAX_NFTS, "Not allowed!");
        balance[to] += total;
        _mintBatch(to, ids, amounts, data);
    }

    function safeTransferFrom(
        address from, 
        address to, 
        uint256 id, 
        uint256 value, 
        bytes memory data
    ) public virtual override {
        address sender = _msgSender();
        if (from != sender && !isApprovedForAll(from, sender)) {
            revert ERC1155MissingApprovalForAll(sender, from);
        }
        require(balance[to] + value <= MAX_NFTS, "Not allowed!");
        balance[from] -= value;
        balance[to] += value;
        _safeTransferFrom(from, to, id, value, data);
    }

    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory values,
        bytes memory data
    ) public virtual override {
        address sender = _msgSender();
        if (from != sender && !isApprovedForAll(from, sender)) {
            revert ERC1155MissingApprovalForAll(sender, from);
        }
        uint256 total = 0;
        for (uint256 i = 0; i < values.length; i++) {
            total += values[i];
        }
        require(balance[to] + total <= MAX_NFTS, "Not allowed!");
        balance[from] -= total;
        balance[to] += total;
        _safeBatchTransferFrom(from, to, ids, values, data);
    }
}