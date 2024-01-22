const hre = require("hardhat");
const { ethers } = require("hardhat");

async function main() {
  const Contract8 = await ethers.getContractFactory("Challenge08");
  const contract8 = await Contract8.deploy();

  console.log("Contract8 Deployed!");
  console.log(`Contract8 Address:  ${contract8.target}`);

  const Contract12 = await ethers.getContractFactory("Challenge12");
  const contract12 = await Contract12.deploy(contract8.target);

  console.log("Contract12 Deployed!");
  console.log(`Contract12 Address:  ${contract12.target}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
