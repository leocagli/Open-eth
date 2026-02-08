import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;

  const { deployer } = await getNamedAccounts();

  console.log("Deploying ReputationRegistry with deployer:", deployer);

  const reputationRegistry = await deploy("ReputationRegistry", {
    from: deployer,
    args: [],
    log: true,
    waitConfirmations: 1,
  });

  console.log("ReputationRegistry deployed to:", reputationRegistry.address);
};

export default func;
func.tags = ["ReputationRegistry"];
