require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.9",
  networks: {
    matic: {
      url: 'https://polygon-mumbai.g.alchemy.com/v2/lTMZ714mcYLS9AitiIqPQYXr2jSEusbd',
      accounts: ['40e8f2be0e4d3263fb17eaf4d7ec8d1e134f9b745e05ccc75bf1ce8255970b55', 'f2c74c0f3f470a783c8edcb2713295bdd8cb420f55a43b9374d846392871e50a', 'a9dd91bf6b719a8929ba63578a88d3b2612d3d2fe32d8bc57704950a42f5eae7', '40e8f2be0e4d3263fb17eaf4d7ec8d1e134f9b745e05ccc75bf1ce8255970b55', '40e8f2be0e4d3263fb17eaf4d7ec8d1e134f9b745e05ccc75bf1ce8255970b55'],
      gas: 2100000,
      gasPrice: 8000000000
    }
  },
};
