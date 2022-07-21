const { ethers, ContractFactory } = require("ethers");

const {
    ACCOUNT1,
    ACCOUNT2,
    ACCOUNT3,
    PROVIDER,
    POOL_ADDRESS,
    POOL_ABI,
    POOL_BYTECODE,
    ZAR_ADDRESS,
    ZAR_ABI
} = require("./constants");

let provider = new ethers.providers.JsonRpcProvider(PROVIDER);

/* HELPERS */

async function queryZARBalance(address) {
   let zar =  new ethers.Contract(ZAR_ADDRESS, ZAR_ABI, provider)
    zar.attach(ZAR_ADDRESS);
    
    let balance = await zar.balanceOf(address);
    console.log(balance.toNumber());
    return balance.toNumber();
}

async function mintZAR(to, amount, privateKey) {
    var zarAddress = ZAR_ADDRESS;
    var zarABI = ZAR_ABI;
    var args = [to, amount];
    await transaction(zarAddress, zarABI, privateKey, "mint", args);
}


async function approvePool(address, amount, privateKey) {
    var zarAddress = ZAR_ADDRESS;
    var zarABI = ZAR_ABI;
    var args = [address, amount];
    await transaction(zarAddress, zarABI, privateKey, "approve", args);
}


async function transaction(address, abi, privateKey, method, args) {
    let signer = new ethers.Wallet(privateKey, provider);
    var abi = abi;
    var contract = new ethers.Contract(address, abi, signer);
    var unsigned_tx = await contract.populateTransaction[method](...args);

    // try {
        await signer.signTransaction(unsigned_tx);
        var tx_receipt = await signer.sendTransaction(unsigned_tx,  {gasLimit: 0x1000});
        console.log(JSON.stringify(tx_receipt));
        return JSON.stringify(tx_receipt);
    // } catch {
    //     console.log("Transaction failed.")
    // }

}

// link efc20 with pool 
async function linkZAR(erc20, privateKey) { 
    var poolAddress = POOL_ADDRESS;
    var poolABI = POOL_ABI;
    var args = [erc20];
    await transaction(poolAddress, poolABI, privateKey, "linkTokenContract", args);

}

// get current balance of pool 
async function getPoolValue() {
    let pool =  new ethers.Contract(POOL_ADDRESS, POOL_ABI, provider)
    pool.attach(POOL_ADDRESS);

    var balance = await pool.getBalance();
    console.log(balance.toNumber())
}


/* FUNCTIONALITY */

// create new investment contract
async function newInvestmentContract(uri, target, interest) {
    let investecAccount = ACCOUNT1;
    let signer = new ethers.Wallet(investecAccount, provider);
    let poolInstance = new ethers.ContractFactory(POOL_ABI, POOL_BYTECODE, signer);
    let pool = await poolInstance.deploy(uri, target, interest);
    
    return pool.address;
}

// deposit into investment
async function deposit(amount, privateKey) {
    privateKey = ACCOUNT2;
    var poolAddress = POOL_ADDRESS;
    var poolABI = POOL_ABI;
    var args = [amount];
    await transaction(poolAddress, poolABI, privateKey, "deposit", args);
}

// claim tokens from investment
async function claim(address, privateKey) {
    var poolAddress = POOL_ADDRESS;
    var poolABI = POOL_ABI;
    var args = [address];
    await transaction(poolAddress, poolABI, privateKey, "claim", args);
}

// set investmet fulfilled (done by Investec once loan is paid back)
async function setFulfilled(privateKey) {
    var poolAddress = POOL_ADDRESS;
    var poolABI = POOL_ABI;
    var args = [];
    await transaction(poolAddress, poolABI, privateKey, "fulfillInvestment", args);
}


// 1. mint erc20 
// 2. approve pool in erc20 
// 3. link erc20 in pool


// mintZAR('0x5E7892F082859CBEC2A08e82A6F487C290ce17e8', 10000, ACCOUNT1)
// queryBalance('0x5E7892F082859CBEC2A08e82A6F487C290ce17e8');
// deposit(10000, ACCOUNT1)

// approvePool(POOL_ADDRESS, 10000000, ACCOUNT2);
// linkZAR(ZAR_ADDRESS, ACCOUNT2)
// mintZAR('0xB04d7086D5BD972e9aA06c75824c2E7589a12669', 1000, ACCOUNT1)
// deposit(10000, ACCOUNT2)
// claim('0x5E7892F082859CBEC2A08e82A6F487C290ce17e8', ACCOUNT1)

