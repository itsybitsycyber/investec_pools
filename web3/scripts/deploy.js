const hre = require("hardhat");

async function main() {
  const poolInstance = await hre.ethers.getContractFactory("Pool");
  // const pool = await poolInstance.deploy("", 1000000, 10);

  // await pool.deployed();

  // console.log("Pool deployed to:", pool.address);
  
  const zarInstance = await hre.ethers.getContractFactory("ZAR");
  const zar = await zarInstance.deploy("ZAR", "ZAR");

  await zar.deployed();

  console.log("ZAR deployed to:", zar.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
