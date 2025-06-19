// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Voting {
    address public contractOwner;

    struct Candidate {
        address addr;
        string name;
        uint8 voteCount;
    }

    // Mapping from candidate address to Candidate struct
    mapping(address => Candidate) private candidates;
    // Mapping from candidate name to address for lookup
    mapping(string => address) private candidateNames;
    // List of candidate addresses for enumeration
    address[] public candidateAddresses;

    address public winner;
    uint public winnerVotes;

    constructor() {
        contractOwner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == contractOwner, "You are not the owner");
        _;
    }

    // Function to register a new candidate with their address and name
    function registerCandidate(address _addr, string memory _name) external onlyOwner {
        require(_addr != address(0), "Invalid candidate address");
        require(bytes(_name).length > 0, "Candidate name cannot be empty");
        require(candidates[_addr].addr == address(0), "Candidate already registered");
        require(candidateNames[_name] == address(0), "Candidate name already registered");

        // Register the candidate
        candidates[_addr] = Candidate({ addr: _addr, name: _name, voteCount: 0 });
        candidateNames[_name] = _addr;
        candidateAddresses.push(_addr);
    }

    // Function to cast a vote for a candidate by their name
    function castVote(string memory _name) external {
        address candidateAddr = candidateNames[_name];
        require(candidateAddr != address(0), "Not a valid candidate");

        // Increment the vote count for the candidate
        candidates[candidateAddr].voteCount++;
        updateWinner(candidateAddr);
    }

    // Function to update the winner based on current votes
    function updateWinner(address _addr) private {
        if (candidates[_addr].voteCount > winnerVotes) {
            winner = _addr;
            winnerVotes = candidates[_addr].voteCount;
        }
    }

    // Function to get the number of votes a candidate has received
    function getVotes(address _addr) public view returns (uint8) {
        require(candidates[_addr].addr != address(0), "Not a valid candidate");
        return candidates[_addr].voteCount;
    }

    // Function to get the name of the candidate with the most votes
    function getWinner() public view returns (string memory) {
        require(winner != address(0), "No winner yet");
        return candidates[winner].name;
    }

    // Function to get the list of candidate addresses
    function getCandidateAddresses() public view returns (address[] memory) {
        return candidateAddresses;
    }

    // Function to get the details of a candidate by their address
    function getCandidateByAddress(address _addr) public view returns (string memory name, uint8 votes) {
        require(candidates[_addr].addr != address(0), "Not a valid candidate");
        Candidate memory candidate = candidates[_addr];
        return (candidate.name, candidate.voteCount);
    }

    // Function to get the details of a candidate by their name
    function getCandidateByName(string memory _name) public view returns (address addr, uint8 votes) {
        address candidateAddr = candidateNames[_name];
        require(candidateAddr != address(0), "Not a valid candidate");
        Candidate memory candidate = candidates[candidateAddr];
        return (candidateAddr, candidate.voteCount);
    }
}
