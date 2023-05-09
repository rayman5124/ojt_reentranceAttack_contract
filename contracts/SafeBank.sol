//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Arrays.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "hardhat/console.sol";

contract SafeBank {
    mapping(address => uint256) public balanceOf;

    function deposit() external payable {
        balanceOf[msg.sender] += msg.value;
    }

    // ==================== 1. Checks-Effects-Interactions 패턴 ====================
    function withdraw() external {
        uint256 currentBalance = balanceOf[msg.sender];
        console.log("current balance of %s : %s ", msg.sender, currentBalance);
        require(currentBalance != 0, "not enough balance to withdraw"); // check 여기 메세지는 출력아 안된다.
        balanceOf[msg.sender] = 0; // effects to the state variables
        (bool success, ) = msg.sender.call{value: currentBalance}("");
        require(success, "withdrwal failed");
    }

    // ==================== 2. prevent-reentrance modifier 사용 ====================

    // 1 -> true
    // 2 -> false
    // uint256 private _entered = 2;

    // modifier _preventReEntrance() {
    //     require(_entered == 2);
    //     _entered = 1;
    //     _;
    //     _entered = 2;
    // }

    // function withdraw() external _preventReEntrance {
    //     console.log("entered");
    //     uint256 depositedAmount = balanceOf[msg.sender];
    //     (bool success, ) = msg.sender.call{value: depositedAmount}("");
    //     require(success, "withdraw failed");
    //     balanceOf[msg.sender] = 0;
    // }
}
