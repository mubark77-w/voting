// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
contract voteing{
  struct Proposal {
   uint256 id;
   string proposal;
   address Address;
}

Proposal[] public proposals;
   mapping(address => bool) public CanVoted;
   address public owner;
    constructor() {
        owner = msg.sender;
    }
    modifier OnlyOwner() {
        require(owner == msg.sender, " only owner");
        _;
    }
    
     function addProposal(uint256 _id, string memory _proposals, address _address) public OnlyOwner {
   proposals.push(Proposal(_id, _proposals, _address));
}
     mapping(uint256 => uint256) public proposalVotes;

function vote(uint256 proposal) public {
    require(CanVoted[msg.sender], "Already voted");
    CanVoted[msg.sender] = true;
    proposalVotes[proposal]++;
}
mapping(uint256 => uint256) public votesCount;
function getVotes(uint256 proposal) public view returns (uint256) {
    return votesCount[proposal];
}
function getAllProposals() public view returns (Proposal[] memory) {
    return proposals;
}


function hasVoted(address user) public view returns (bool) {
    return CanVoted[user];
}
  function proposalCount() public view returns (uint256) {
    return proposals.length;
}
mapping (address Proposal=> uint256 Proposaladdress) public numofProposal;

function getWinner() public {
    for (uint256 proposalIndex = 0; proposalIndex < proposals.length; proposalIndex++) {
        address proposalAddress = proposals[proposalIndex].Address;
        numofProposal[proposalAddress] = 0;
    }
}
function getProposal(uint256 proposalId) public view returns (Proposal memory) {
    return proposals[proposalId];
}


}