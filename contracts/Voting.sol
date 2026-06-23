// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Voting {
    // variable
    struct Proposal {
        uint256 id;
        string name;
        address proposer;
        uint256 voteCount; 
    } 
    
    Proposal[] public proposals;
    // this mapping to know if this address voted or not
    
    mapping(address => bool) public CanVoted ;
    
    address public owner;


    
// this address in this point he is the owner
    constructor() {
        owner = msg.sender;
    }
// this is modifier to give only owner access for specific  function
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
//  this function to add proposal information id , his name , address
    function addProposal(uint256 _id, string memory _name , address _proposer ) public onlyOwner {
        require(_id == proposals.length, "Invalid proposal ID");
        proposals.push(Proposal({
    id: _id,
    name: _name,
    proposer: _proposer,
    voteCount: 0
}));
        
    }
// function to any one can vote
    function vote(uint256 proposalId) public {
        require(CanVoted[msg.sender], "Already voted");
        CanVoted[msg.sender] = true;
        proposals[proposalId].voteCount++;
        
    }
    // function to get vote count for propsal
    function getVotes(uint proposalId) public view returns (uint) {
        return proposals[proposalId].voteCount;
}
// i want to know all proposals in this contract
    function getAllProposals() public view returns (Proposal[] memory) {
        return proposals;
}
// function to know how many prposals in this contract
mapping(address => uint256) public numofProposal;
   function proposalCount() public {
    for (uint256 proposalindex = 0; proposalindex < proposals.length; proposalindex++) {
        address proposer = proposals[proposalindex].proposer;
        numofProposal[proposer] = 0;
    }
}
// function to know who is winner 
// loop get all proposals and sort with who is have much votes
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
    // function to get propsal id 
     function getProposal(uint256 proposalId) public view returns (Proposal memory) {
        require(proposalId < proposals.length, "Invalid proposal ID");
        return proposals[proposalId];
}

    // to close voting 

    function closeVoting() public view onlyOwner {
        (block.timestamp);

}
// to reset all vote in contract
    function resetVoting() public onlyOwner {
    for (uint256 i = 0; i < proposals.length; i++) {
        proposals[i].voteCount = 0;

    }
}





















}