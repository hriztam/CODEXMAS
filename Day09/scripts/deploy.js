const hre = require("hardhat");
const { ethers } = require("hardhat");

async function main() {
  const Contract = await ethers.getContractFactory("Challenge09");
  const contract = await Contract.deploy();
  console.log("Contract Deployed!");
  console.log(`Contract Address:  ${contract.target} `);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
