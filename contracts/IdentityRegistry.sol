// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title IdentityRegistry
 * @dev Registry for managing user identities in the Open-eth ecosystem
 */
contract IdentityRegistry is Ownable {
    struct Identity {
        address userAddress;
        bytes32 identityHash;
        uint256 registeredAt;
        bool isActive;
    }

    mapping(address => Identity) public identities;
    mapping(bytes32 => address) public identityHashToAddress;

    event IdentityRegistered(address indexed user, bytes32 identityHash);
    event IdentityUpdated(address indexed user, bytes32 newIdentityHash);
    event IdentityDeactivated(address indexed user);

    constructor() Ownable(msg.sender) {}

    function registerIdentity(bytes32 _identityHash) external {
        require(!identities[msg.sender].isActive, "Identity already registered");
        require(identityHashToAddress[_identityHash] == address(0), "Identity hash already in use");

        identities[msg.sender] = Identity({
            userAddress: msg.sender,
            identityHash: _identityHash,
            registeredAt: block.timestamp,
            isActive: true
        });

        identityHashToAddress[_identityHash] = msg.sender;

        emit IdentityRegistered(msg.sender, _identityHash);
    }

    function updateIdentity(bytes32 _newIdentityHash) external {
        require(identities[msg.sender].isActive, "Identity not registered");
        require(identityHashToAddress[_newIdentityHash] == address(0), "Identity hash already in use");

        bytes32 oldHash = identities[msg.sender].identityHash;
        delete identityHashToAddress[oldHash];

        identities[msg.sender].identityHash = _newIdentityHash;
        identityHashToAddress[_newIdentityHash] = msg.sender;

        emit IdentityUpdated(msg.sender, _newIdentityHash);
    }

    function deactivateIdentity() external {
        require(identities[msg.sender].isActive, "Identity not active");

        identities[msg.sender].isActive = false;

        emit IdentityDeactivated(msg.sender);
    }

    function getIdentity(address _user) external view returns (Identity memory) {
        return identities[_user];
    }

    function isIdentityActive(address _user) external view returns (bool) {
        return identities[_user].isActive;
    }
}
