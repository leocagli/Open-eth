// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title ReputationRegistry
 * @dev Registry for managing user reputation scores in the Open-eth ecosystem
 */
contract ReputationRegistry is Ownable {
    struct Reputation {
        uint256 score;
        uint256 totalTransactions;
        uint256 successfulTransactions;
        uint256 lastUpdated;
    }

    mapping(address => Reputation) public reputations;

    event ReputationUpdated(address indexed user, uint256 newScore);
    event TransactionRecorded(address indexed user, bool success);

    uint256 public constant MIN_SCORE = 0;
    uint256 public constant MAX_SCORE = 1000;
    uint256 public constant INITIAL_SCORE = 500;

    constructor() Ownable(msg.sender) {}

    function initializeReputation(address _user) external onlyOwner {
        require(reputations[_user].lastUpdated == 0, "Reputation already initialized");

        reputations[_user] = Reputation({
            score: INITIAL_SCORE,
            totalTransactions: 0,
            successfulTransactions: 0,
            lastUpdated: block.timestamp
        });

        emit ReputationUpdated(_user, INITIAL_SCORE);
    }

    function recordTransaction(address _user, bool _success) external onlyOwner {
        Reputation storage rep = reputations[_user];

        if (rep.lastUpdated == 0) {
            reputations[_user] = Reputation({
                score: INITIAL_SCORE,
                totalTransactions: 0,
                successfulTransactions: 0,
                lastUpdated: block.timestamp
            });
            rep = reputations[_user];
        }

        rep.totalTransactions++;
        if (_success) {
            rep.successfulTransactions++;
            if (rep.score < MAX_SCORE) {
                rep.score += 1;
            }
        } else {
            if (rep.score > MIN_SCORE) {
                rep.score -= 2;
            }
        }

        rep.lastUpdated = block.timestamp;

        emit TransactionRecorded(_user, _success);
        emit ReputationUpdated(_user, rep.score);
    }

    function getReputation(address _user) external view returns (Reputation memory) {
        return reputations[_user];
    }

    function getScore(address _user) external view returns (uint256) {
        return reputations[_user].score;
    }

    function getSuccessRate(address _user) external view returns (uint256) {
        Reputation memory rep = reputations[_user];
        if (rep.totalTransactions == 0) {
            return 0;
        }
        return (rep.successfulTransactions * 100) / rep.totalTransactions;
    }
}
