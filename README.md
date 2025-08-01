# 🗳️ Decentralized Voting Smart Contract

A secure and transparent voting system built in Solidity for the Ethereum blockchain.

<img src="https://github.com/user-attachments/assets/9352d5d2-505a-4a2b-98ff-9e2af9e32978" width="190"/>


## Features
- Owner-only candidate registration
- Voting by candidate name
- Real-time winner tracking
- View candidate details and vote counts

## Tech Stack
- Solidity ^0.8.26
- Tested on Remix IDE

## How to Use
1. Deploy the contract on Remix.
2. Register candidates using `registerCandidate(address, name)` (owner only).
3. Cast votes with `castVote(name)`.
4. View results using `getWinner()`, `getVotes(address)`, or `getCandidateByName(name)`.

## License
MIT
