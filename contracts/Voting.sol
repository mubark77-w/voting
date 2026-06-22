// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Voting {
    struct Proposal {
        uint256 id;
        string name;
        address proposer;
        uint256 voteCount;
    } 

    Proposal[] public proposals;
    mapping(address => bool) public CanVoted ;
    address public owner;

    

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function addProposal(uint256 _id, string memory _name , address _proposer ) public onlyOwner {
        require(_id == proposals.length, "Invalid proposal ID");
        proposals.push(Proposal({
    id: _id,
    name: _name,
    proposer: _proposer,
    voteCount: 0
}));
        
    }

    function vote(uint256 proposalId) public {
        require(CanVoted[msg.sender], "Already voted");
        CanVoted[msg.sender] = true;
        proposals[proposalId].voteCount++;
        
    }
    function getVotes(uint proposalId) public view returns (uint) {
        return proposals[proposalId].voteCount;
}

    function getAllProposals() public view returns (Proposal[] memory) {
        return proposals;
}

mapping(address => uint256) public numofProposal;
   function proposalCount() public {
    for (uint256 proposalindex = 0; proposalindex < proposals.length; proposalindex++) {
        address proposer = proposals[proposalindex].proposer;
        numofProposal[proposer] = 0;
    }
}

    function getWinner() public view returns (Proposal memory) {
        require(proposals.length > 0, "No proposals exist");
        Proposal memory winner = proposals[0];
        for (uint256 i = 1; i < proposals.length; i++) {
            if (proposals[i].voteCount > winner.voteCount) {
                winner = proposals[i];
            }
        }
        return winner;
    }
     function getProposal(uint256 proposalId) public view returns (Proposal memory) {
        require(proposalId < proposals.length, "Invalid proposal ID");
        return proposals[proposalId];
}

    

    function closeVoting() public view onlyOwner {
        (block.timestamp);

}
    function resetVoting() public onlyOwner {
    for (uint256 i = 0; i < proposals.length; i++) {
        proposals[i].voteCount = 0;

    }
}





















}