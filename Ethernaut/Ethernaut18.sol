pragma solidity ^0.8;

interface IMagicNum {
    function setSolver(address) external;
}

interface ISolver {
    function whatIsTheMeaningOfLife() external view returns (uint256);
}

contract Hack {
    constructor(IMagicNum target) {
        bytes memory bytecode = hex"69602a60005260206000f3600052600a6016f3";
        address addr;
        assembly {
            // create(göndermek istediğimiz eth miktarı ,kodun bytecode içindeki başladığı nokta , kodun(kontratın) byte boyutu)
            addr := create(0, add(bytecode, 0x20), 0x13)
        }
        target.setSolver(addr);
    }
}

// kaynakça : https://www.evm.codes/playground
//Kullanılan ingilizce kelimeler daha havalı olmak için değil =) bazı kelimeleri çevirmek, anlamayı zorlaştırıyordu.
/*
Runtime Code = Çalıştırılabilir bir kodu refere eder (makine kodu gördüğünde ne yapması gerektiğini anlar)

PUSH -> Stack'in en üstüne verilen değeri yerleştirir

42 değerini return eden runtime kodu: 602a60005260206000f3

+)42 yi hafızaya depolamak için:
mstore(p, v) - v değerini p den p + 32 ye kadar olan memory de depolar

PUSH1 0x2a -> hexadecimallerde 42 = 0x2a
PUSH1 0
MSTORE

+)Memoryden 32 byte returnler
işlemi tamamlar ve p den p + s e kadar olan memorydeki datayı returnler

PUSH1 0x20 -> 0x20 hexadecimallerde 32 ye eşit
PUSH1 0
RETURN

-Creation code - runtime kodunu returnler
69602a60005260206000f3600052600a6016f3

-Run time kodu memory de depolar
PUSH10 0X602a60005260206000f3
PUSH1 0
MSTORE

+)22. pozisyondan başlayacak şekilde memoryden 10 byte returnler
PUSH1 0x0a -> 0x0a = 10
PUSH1 0x16 -> 0x16 = 22
RETURN
*/
