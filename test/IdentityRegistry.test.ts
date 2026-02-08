import { expect } from "chai";
import { ethers } from "hardhat";
import { IdentityRegistry } from "../typechain-types";
import { HardhatEthersSigner } from "@nomicfoundation/hardhat-ethers/signers";

describe("IdentityRegistry", function () {
  let identityRegistry: IdentityRegistry;
  let owner: HardhatEthersSigner;
  let user1: HardhatEthersSigner;
  let user2: HardhatEthersSigner;

  beforeEach(async function () {
    [owner, user1, user2] = await ethers.getSigners();

    const IdentityRegistryFactory = await ethers.getContractFactory("IdentityRegistry");
    identityRegistry = await IdentityRegistryFactory.deploy();
    await identityRegistry.waitForDeployment();
  });

  describe("Registration", function () {
    it("Should register a new identity", async function () {
      const identityHash = ethers.keccak256(ethers.toUtf8Bytes("test-identity"));

      await expect(identityRegistry.connect(user1).registerIdentity(identityHash))
        .to.emit(identityRegistry, "IdentityRegistered")
        .withArgs(user1.address, identityHash);

      const identity = await identityRegistry.getIdentity(user1.address);
      expect(identity.userAddress).to.equal(user1.address);
      expect(identity.identityHash).to.equal(identityHash);
      expect(identity.isActive).to.be.true;
    });

    it("Should not allow duplicate identity registration", async function () {
      const identityHash = ethers.keccak256(ethers.toUtf8Bytes("test-identity"));

      await identityRegistry.connect(user1).registerIdentity(identityHash);

      await expect(
        identityRegistry.connect(user1).registerIdentity(ethers.keccak256(ethers.toUtf8Bytes("new-identity")))
      ).to.be.revertedWith("Identity already registered");
    });

    it("Should not allow duplicate identity hash", async function () {
      const identityHash = ethers.keccak256(ethers.toUtf8Bytes("test-identity"));

      await identityRegistry.connect(user1).registerIdentity(identityHash);

      await expect(
        identityRegistry.connect(user2).registerIdentity(identityHash)
      ).to.be.revertedWith("Identity hash already in use");
    });
  });

  describe("Update", function () {
    it("Should update identity", async function () {
      const identityHash = ethers.keccak256(ethers.toUtf8Bytes("test-identity"));
      const newIdentityHash = ethers.keccak256(ethers.toUtf8Bytes("new-identity"));

      await identityRegistry.connect(user1).registerIdentity(identityHash);

      await expect(identityRegistry.connect(user1).updateIdentity(newIdentityHash))
        .to.emit(identityRegistry, "IdentityUpdated")
        .withArgs(user1.address, newIdentityHash);

      const identity = await identityRegistry.getIdentity(user1.address);
      expect(identity.identityHash).to.equal(newIdentityHash);
    });
  });

  describe("Deactivation", function () {
    it("Should deactivate identity", async function () {
      const identityHash = ethers.keccak256(ethers.toUtf8Bytes("test-identity"));

      await identityRegistry.connect(user1).registerIdentity(identityHash);

      await expect(identityRegistry.connect(user1).deactivateIdentity())
        .to.emit(identityRegistry, "IdentityDeactivated")
        .withArgs(user1.address);

      const isActive = await identityRegistry.isIdentityActive(user1.address);
      expect(isActive).to.be.false;
    });
  });
});
