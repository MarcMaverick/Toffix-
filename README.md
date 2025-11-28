// scripts/deploy.js
// Deployment: npx hardhat run scripts/deploy.js --network base

const fs = require("fs");
const path = require("path");

async function main() {
  const hre = require("hardhat");
  const { ethers } = hre;

  // Load deployer
  const [deployer] = await ethers.getSigners();
  console.log("Deployer:", deployer.address);
  console.log("Balance:", ethers.utils.formatEther(await deployer.getBalance()), "ETH");

  // Treasury address
  const treasury =
    process.env.TREASURY && process.env.TREASURY !== ""
      ? process.env.TREASURY
      : deployer.address;

  console.log("Treasury:", treasury);

  // Ensure fresh compile
  await hre.run("compile");

  // Contract factory
  const ToffixFactory = await ethers.getContractFactory("Toffix");
  console.log("Deploying TOFFIX...");

  // Deploy contract
  const toffix = await ToffixFactory.deploy(treasury);
  await toffix.deployed();

  console.log("TOFFIX deployed at:", toffix.address);

  // Write output
  const outPath = path.join(__dirname, "..", "deployed-address.txt");
  fs.writeFileSync(
    outPath,
    `TOFFIX=${toffix.address}\nTREASURY=${treasury}\nNETWORK=${hre.network.name}\n`,
    "utf8"
  );

  console.log("Saved deployment info to deployed-address.txt");

  // Optional verify
  const apiKey = process.env.BASESCAN_API_KEY;
  if (apiKey && apiKey !== "") {
    console.log("Verifying contract...");
    await toffix.deployTransaction.wait(5);

    try {
      await hre.run("verify:verify", {
        address: toffix.address,
        constructorArguments: [treasury],
      });
      console.log("Verification successful.");
    } catch (e) {
      console.log("Verification failed. Run manually:");
      console.log(
        `npx hardhat verify --network base ${toffix.address} ${treasury}`
      );
    }
  } else {
    console.log("No BASESCAN_API_KEY set → skipping verification.");
  }
}

main().catch((err) => {
  console.error("Deployment error:", err);
  process.exit(1);
});
