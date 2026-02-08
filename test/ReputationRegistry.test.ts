import { expect } from "chai";
import { ethers } from "hardhat";
import { ReputationRegistry } from "../typechain-types";
import { HardhatEthersSigner } from "@nomicfoundation/hardhat-ethers/signers";

describe("ReputationRegistry", function () {
  let reputationRegistry: ReputationRegistry;
  let owner: HardhatEthersSigner;
  let user1: HardhatEthersSigner;

  beforeEach(async function () {
    [owner, user1] = await ethers.getSigners();

    const ReputationRegistryFactory = await ethers.getContractFactory("ReputationRegistry");
    reputationRegistry = await ReputationRegistryFactory.deploy();
    await reputationRegistry.waitForDeployment();
  });

  describe("Initialization", function () {
    it("Should initialize reputation with default score", async function () {
      await reputationRegistry.initializeReputation(user1.address);

      const reputation = await reputationRegistry.getReputation(user1.address);
      expect(reputation.score).to.equal(500); // INITIAL_SCORE
      expect(reputation.totalTransactions).to.equal(0);
      expect(reputation.successfulTransactions).to.equal(0);
    });

    it("Should not allow duplicate initialization", async function () {
      await reputationRegistry.initializeReputation(user1.address);

      await expect(
        reputationRegistry.initializeReputation(user1.address)
      ).to.be.revertedWith("Reputation already initialized");
    });
  });

  describe("Transaction Recording", function () {
    it("Should increase score on successful transaction", async function () {
      await reputationRegistry.initializeReputation(user1.address);

      await reputationRegistry.recordTransaction(user1.address, true);

      const reputation = await reputationRegistry.getReputation(user1.address);
      expect(reputation.score).to.equal(501);
      expect(reputation.successfulTransactions).to.equal(1);
      expect(reputation.totalTransactions).to.equal(1);
    });

    it("Should decrease score on failed transaction", async function () {
      await reputationRegistry.initializeReputation(user1.address);

      await reputationRegistry.recordTransaction(user1.address, false);

      const reputation = await reputationRegistry.getReputation(user1.address);
      expect(reputation.score).to.equal(498);
      expect(reputation.successfulTransactions).to.equal(0);
      expect(reputation.totalTransactions).to.equal(1);
    });

    it("Should calculate success rate correctly", async function () {
      await reputationRegistry.initializeReputation(user1.address);

      await reputationRegistry.recordTransaction(user1.address, true);
      await reputationRegistry.recordTransaction(user1.address, true);
      await reputationRegistry.recordTransaction(user1.address, false);

      const successRate = await reputationRegistry.getSuccessRate(user1.address);
      expect(successRate).to.equal(66); // 2/3 * 100 = 66
    });
  });
});
