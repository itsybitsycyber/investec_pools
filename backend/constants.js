const ACCOUNT1 = '0x40e8f2be0e4d3263fb17eaf4d7ec8d1e134f9b745e05ccc75bf1ce8255970b55'; // investec's wallet
const ACCOUNT2 = '0xf2c74c0f3f470a783c8edcb2713295bdd8cb420f55a43b9374d846392871e50a'; // user's wallet
const ACCOUNT3 = '0xa9dd91bf6b719a8929ba63578a88d3b2612d3d2fe32d8bc57704950a42f5eae7';

const ADDRESS1 = '0xB04d7086D5BD972e9aA06c75824c2E7589a12669'; // investec's wallet
const ADDRESS2 = '0x5E7892F082859CBEC2A08e82A6F487C290ce17e8'; // user's wallet
const ADDRESS3 = '0x158fA8e20115fABb7132b6930c145DEA66816e2b';

// const PROVIDER = 'https://polygon-mumbai.g.alchemy.com/v2/lTMZ714mcYLS9AitiIqPQYXr2jSEusbd';
// const PROVIDER = 'https://matic-mumbai.chainstacklabs.com'
const PROVIDER = 'https://rpc.ankr.com/polygon_mumbai'

let pool = require('../web3/artifacts/contracts/Pool.sol/Pool.json');
const POOL_ADDRESS = '0x8fD25c40a14680113E5f4C23C80189d3B3550C88'
const POOL_ABI = pool.abi
const POOL_BYTECODE = pool.bytecode
const POOL_IPFS = 'https://ipfs.io/ipfs/QmeKppUZsPWvgoJJAwC4RXqMRDyFKAhN79CPdsraf8ugnq'

let zar = require('../web3/artifacts/contracts/ZAR.sol/ZAR.json');
const ZAR_ADDRESS = '0x354154d0C8880f8E4895aCF5F31Bbc74A5360f56'
const ZAR_ABI = zar.abi

module.exports = {
    ACCOUNT1,
    ACCOUNT2,
    ACCOUNT3,
    ADDRESS1,
    ADDRESS2,
    ADDRESS3,
    PROVIDER,
    POOL_ADDRESS,
    POOL_ABI, 
    POOL_BYTECODE,
    ZAR_ADDRESS,
    ZAR_ABI
};