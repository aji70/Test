// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import './AjiNFT.sol';

contract Staking is AjiNFT {

    uint256 public stakingDuration; // Duration for staking in seconds
    uint256 public rewardRate = 10; // Annual reward rate (in percentage)

    struct Stake {
    uint256 startAmount;
    uint256  startTime; 
}
 mapping(address => Stake) public stakers;

    constructor(){
        require(balanceOf(msg.sender) > 0, "You have no tokens to stake");
        uint tokenId;
    }

    function stake(uint256 _amount) external {
        require(_amount > 0, "Amount must be greater than zero");
        require(stakers[msg.sender].startAmount == 0, "You have already staked");
    //    require(tokenOwners[tokenId] == msg.sender, "Token not owned by sender");
        stakers[msg.sender] = Stake(_amount, block.timestamp);
       }

}
