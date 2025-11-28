TOFFIX/
 └── contracts/
       └── Toffix.sol
git add .
git commit -m "Add final Toffix.sol smart contract"
git push origin main
// scripts/deploy.js
// Usage:
//   # local manual deploy:
//   npx hardhat run scripts/deploy.js --network base
//
// Notes:
// - Expects environment variables: TREASURY (optional), BASESCAN_API_KEY (optional)
// - For GitHub Actions, set PRIVATE_KEY, BASE_RPC, TREASURY, BASESCAN_API_KEY as repository secrets

const fs = require("fs");
const path = require("path");

async function main() {
  const hre = require("hardhat");
  const { ethers } = hre;

  // Deployer / signer
  const [deployer] = await ethers.getSigners();
  console.log("Deployer address:", deployer.address);
  const balance = await deployer.getBalance();
  console.log("Deployer balance:", ethers.utils.formatEther(balance), "ETH");

  // Treasury address: prefer env var, fallback to deployer
  const treasury = process.env.TREASURY && process.env.TREASURY !== ""
    ? process.env.TREASURY
    : deployer.address;

  if (!treasury || treasury === ethers.constants.AddressZero) {
    throw new Error("Invalid treasury address. Set TREASURY env var or ensure deployer is available.");
  }
  console.log("Using treasury address:", treasury);

  // Compile (ensure up-to-date)
  await hre.run("compile");

  // Deploy Toffix
  const Toffix = await ethers.getContractFactory("Toffix");
  console.log("Deploying Toffix...");
  const toffix = await Toffix.deploy(treasury, {
    // you can set gas options here if desired, e.g. gasLimit: 8_000_000
  });

  await toffix.deployed();
  console.log("Toffix deployed at:", toffix.address);

  // Write deployed address to file for later use
  const outPath = path.join(__dirname, "..", "deployed-address.txt");
  fs.writeFileSync(outPath, `TOFFIX=${toffix.address}\nTREASURY=${treasury}\nNETWORK=${hre.network.name}\n`, { encoding: "utf8" });
  console.log("Wrote deployed address to", outPath);

  // Optional: verify on Basescan if API key provided
  // Note: requires hardhat-etherscan plugin configured in hardhat.config.js
  const baseScanKey = process.env.BASESCAN_API_KEY || process.env.BASESCAN_API;
  if (baseScanKey && baseScanKey !== "") {
    console.log("BASESCAN_API_KEY detected — attempting contract verification (may take a few minutes)...");
    try {
      // Wait a few confirmations for better verification reliability (optional)
      console.log("Waiting 5 confirmations...");
      await toffix.deployTransaction.wait(5);

      await hre.run("verify:verify", {
        address: toffix.address,
        constructorArguments: [treasury],
      });
      console.log("Verification complete.");
    } catch (err) {
      console.warn("Verification failed or timed out. You can verify later with:");
      console.warn(`  npx hardhat verify --network ${hre.network.name} ${toffix.address} ${treasury}`);
      console.warn("Error:", (err && err.message) ? err.message : err);
    }
  } else {
    console.log("No BASESCAN_API_KEY provided — skipping automatic verification.");
    console.log(`To verify manually later run:\n  npx hardhat verify --network ${hre.network.name} ${toffix.address} ${treasury}`);
  }

  console.log("Done.");
}

main().catch((error) => {
  console.error("Error in deployment:", error);
  process.exitCode = 1;
});
