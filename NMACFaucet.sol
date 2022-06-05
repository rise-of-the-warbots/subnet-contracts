// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/access/Ownable.sol";

contract NMACFaucet is Ownable {
	
    mapping(address => uint256) public lockTime;

    // set allowed request amount
    function setAmountAllowed(uint256 newAmountAllowed) public onlyOwner {
        amountAllowed = newAmountAllowed;
    }
    uint256 public amountAllowed = 10 * 10**18;

	function donate() public payable {}
    function request(address payable _to) public payable {

        require(block.timestamp > lockTime[msg.sender], "Faucet: Lock time has not expired. Please try again later!");
        require(address(this).balance > amountAllowed, "Faucet: Not enough funds in the faucet. Please consider donating!");

        _to.transfer(amountAllowed);        
 
        //updates locktime 1 day from now
        lockTime[msg.sender] = block.timestamp + 1 days;
    }
}
