//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract VulnerableBank {
    mapping(address => uint256) public balanceOf;

    function deposit() external payable {
        balanceOf[msg.sender] += msg.value;
    }

    function withdraw() external {
        console.log("entered");
        uint256 depositedAmount = balanceOf[msg.sender];
        (bool success, ) = msg.sender.call{value: depositedAmount}("");
        require(success, "withdraw failed");
        balanceOf[msg.sender] = 0;
    }
}
