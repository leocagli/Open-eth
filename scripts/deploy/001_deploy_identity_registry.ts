import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;

  const { deployer } = await getNamedAccounts();

  console.log("Deploying IdentityRegistry with deployer:", deployer);

  const identityRegistry = await deploy("IdentityRegistry", {
    from: deployer,
    args: [],
    log: true,
    waitConfirmations: 1,
  });

  console.log("IdentityRegistry deployed to:", identityRegistry.address);
};

export default func;
func.tags = ["IdentityRegistry"];
