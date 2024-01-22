// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

import "./Challenge08.sol";

contract Challenge12 {
    Challenge08 public nftContract;

    enum VoteOption { YAY, NAY }

    mapping (address => mapping (uint256 => bool)) public voted;

    struct Proposal {
        string description;
        uint256 totalVotes;
        uint256 yayVotes;
        uint256 nayVotes;
        bool executed;
    }

    Proposal[] public proposals;

    constructor(address _nftAddress) {
        nftContract = Challenge08(_nftAddress);
    }

    function submitProposal(string memory _description) public {
        require(nftContract.getBalanceOfUser(msg.sender) > 0, "Must own an NFT to submit");
        Proposal memory newProposal = Proposal({
            description: _description,
            totalVotes: 0,
            yayVotes: 0,
            nayVotes: 0,
            executed: false
        });
        proposals.push(newProposal);
    }

    function vote(uint256 proposalId, VoteOption option) public {
        require(proposalId < proposals.length, "Invalid proposal");
        Proposal storage proposal = proposals[proposalId];
        require(!proposal.executed, "Proposal already executed");
        require(nftContract.getBalanceOfUser(msg.sender) > 0, "Must own an NFT to vote");
        require(!voted[msg.sender][proposalId], "Already voted on this proposal");

        voted[msg.sender][proposalId] = true;
        proposal.totalVotes += 1;

        if (option == VoteOption.YAY) {
            proposal.yayVotes += 1;
        } else {
            proposal.nayVotes += 1;
        }
    }

    function executeProposal(uint256 proposalId) public {
        require(proposalId < proposals.length, "Invalid proposal");
        Proposal storage proposal = proposals[proposalId];
        require(!proposal.executed, "Proposal already executed");

        if (((proposal.yayVotes * 100) / proposal.totalVotes) > 50) {
            proposal.executed = true;
        }
    }

    function getProposalCount() public view returns (uint256) {
        return proposals.length;
    }

    function getProposal(uint256 proposalId) public view returns (string memory description, uint256 yayVotes, uint256 nayVotes, bool executed) {
        require(proposalId < proposals.length, "Invalid proposal");
        Proposal storage proposal = proposals[proposalId];
        return (proposal.description, proposal.yayVotes, proposal.nayVotes, proposal.executed);
    }
}
