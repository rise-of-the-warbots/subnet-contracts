// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/access/Ownable.sol";

contract NMACFaucet is Ownable {

    constructor() {
        oracle = msg.sender;
    }

    mapping(address => uint256) public userLockTimes;

    // set lock time
    function setLockTime(uint256 newLockTime) public onlyOwner {
        lockTime = newLockTime;
    }
    uint256 public lockTime = 1 days;

    // set allowed request amount
    function setAmountAllowed(uint256 newAmountAllowed) public onlyOwner {
        amountAllowed = newAmountAllowed;
    }
    uint256 public amountAllowed = 10 * 10**18;

    // set oracle agent
    function setOracle(address newOracle) public onlyOwner {
        oracle = newOracle;
    }
    address public oracle;

    function balance() public view returns (uint256) {
        return address(this).balance;
    }
    function remainingLockTime(address _user) public view returns (uint256) {
        if (block.timestamp > userLockTimes[_user]) return 0;
        return userLockTimes[_user] - block.timestamp;
    }
    function isStillLocked(address _user) public view returns (bool) {
        return block.timestamp <= userLockTimes[_user];
    }

    // allows users to deposit tokens
    function donate() public payable {}

    // this can be used by any user as long as they already have native tokens for gas
    function request(address payable _to) public {

        require(block.timestamp > userLockTimes[msg.sender], "Faucet: Lock time has not expired. Please try again later!");
        require(address(this).balance > amountAllowed, "Faucet: Not enough funds in the faucet. Please consider donating!");

        _to.transfer(amountAllowed);        
        userLockTimes[msg.sender] = block.timestamp + lockTime;
    }

    // this is the function the oracle uses to send funds
    function requestFor(address payable _to) public onlyOracle {

        require(block.timestamp > userLockTimes[_to], "Faucet: Lock time has not expired. Please try again later!");
        require(address(this).balance > amountAllowed, "Faucet: Not enough funds in the faucet. Please consider donating!");

        _to.transfer(amountAllowed);
        userLockTimes[_to] = block.timestamp + lockTime;
    }

    // this can be used by the owner to drain the contract in migration scenarios
    function withdraw(uint256 _amount) public onlyOwner {
        require(address(this).balance >= _amount, "Faucet: Amount to withdraw is too large!");

        payable(msg.sender).transfer(_amount);
    }

    modifier onlyOracle() {
        require(oracle == msg.sender, "Faucet: caller is not the oracle");
        _;
    }
}
