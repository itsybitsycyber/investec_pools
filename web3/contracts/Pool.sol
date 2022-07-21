// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Pool { 
    string uri; 
    address[] investors;
    mapping(address => uint256) public deposits; 
    uint target;
    uint interest;
    address erc20;
    bool targetReached;
    bool fulfilled; 
    

    constructor(string memory _uri, uint _target, uint _interest) { 
        uri = _uri;
        target = _target;
        interest = _interest;
    }


    function deposit(uint amount) public {
        // checks 
        // require(IERC20(erc20).balanceOf(msg.sender) < amount, "Amount exceeds user balance");
        // require(target > getBalance(), "Target already met");

        // effects 
        deposits[msg.sender] += amount;

        if(getBalance() >= target){ 
            // target reached
            targetReached = true;
        }

        // integrations
        IERC20(erc20).transferFrom(msg.sender, address(this), amount);


    }

    function claim(address claimee) public {
        // checks 
        require(deposits[claimee] > 0, "User cannot claim");
        require(fulfilled == true, "Investment not completed yet");
        
        // effects 
        uint amount = deposits[claimee] + deposits[claimee]/100 * interest;
        deposits[claimee] = 0;

        // integrations
        IERC20(erc20).transfer(claimee, amount);

    }

    // TODO: make onlyOwner
    function linkTokenContract(address _erc20) public { 
        erc20 = _erc20;
    }

    // TODO: make internal
    function getBalance() public view returns(uint256){
        return IERC20(erc20).balanceOf(address(this));
    }

    // TODO: make onlyOwner (i.e. only the deployer of the contract (Investec) can run this function
    function depositInterest(uint interestEarned) public { 
        require(IERC20(erc20).balanceOf(address(msg.sender)) > interestEarned, "Amount exceeds user balance");
        IERC20(erc20).transferFrom(msg.sender, address(this), interestEarned);
    }

    // TODO: make onlyOwner
    function fulfillInvestment() public view { 

        // checks 
        // require(getBalance() > target, "Investment not fulfilled");

        // effects
        fulfilled == true;


        // integrations 


    }
}