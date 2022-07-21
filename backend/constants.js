const ACCOUNT1 = '0x40e8f2be0e4d3263fb17eaf4d7ec8d1e134f9b745e05ccc75bf1ce8255970b55'; // investec's wallet
const ACCOUNT2 = '0xf2c74c0f3f470a783c8edcb2713295bdd8cb420f55a43b9374d846392871e50a'; // user's wallet
const ACCOUNT3 = '0xa9dd91bf6b719a8929ba63578a88d3b2612d3d2fe32d8bc57704950a42f5eae7';

const PROVIDER = 'https://polygon-mumbai.g.alchemy.com/v2/lTMZ714mcYLS9AitiIqPQYXr2jSEusbd';

let pool = require('../web3/artifacts/contracts/Pool.sol/Pool.json');
// const POOL_ADDRESS = '0xb48b9fCC7D2e82728FCc7111ce3068264B3C2f34'
const POOL_ADDRESS = '0x39b1C256CeE66FcaE65A256CAd720Eb1F49Fce62'
const POOL_ABI = pool.abi
const POOL_BYTECODE = pool.bytecode
const POOL_IPFS = 'http://ipfs.io/ipfs/QmT7MyHU7cM7uzwfw9ZvavB88117tZ7rkD429kqQczAGuu'

let zar = require('../web3/artifacts/contracts/ZAR.sol/ZAR.json');
const ZAR_ADDRESS = '0x354154d0C8880f8E4895aCF5F31Bbc74A5360f56'
const ZAR_ABI = zar.abi

module.exports = {
    ACCOUNT1,
    ACCOUNT2,
    ACCOUNT3,
    PROVIDER,
    POOL_ADDRESS,
    POOL_ABI, 
    POOL_BYTECODE,
    ZAR_ADDRESS,
    ZAR_ABI
};