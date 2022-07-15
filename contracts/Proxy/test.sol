// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// NOTE: Deploy this contract first
contract V1 {
  // NOTE: storage layout must be the same as contract A
  uint256 public num;
  address public sender;
  uint256 public value;
  address public targetContract;

  function setVars(uint256 _num) public payable {
    num = _num;
    sender = msg.sender;
    value = msg.value;
  }

  function upgradeTargetContract(address _newTargetContract) public {
    targetContract = _newTargetContract;
  }
}

contract Proxy {
  uint256 public num;
  address public sender;
  uint256 public value;
  address public targetContract;

  function setVars(uint256 _num) public payable {
    // A's storage is set, B is not modified.
    (bool success, bytes memory data) = targetContract.delegatecall(
      abi.encodeWithSignature("setVars(uint256)", _num)
    );
  }

  function upgradeTargetContract(address _newTargetContract) public {
    (bool success, bytes memory data) = targetContract.delegatecall(
      abi.encodeWithSignature(
        "upgradeTargetContract(address)",
        _newTargetContract
      )
    );
  }
}

// SPDX-License-Identifier: MIT

// contract C {
//   address public owner; // slot 0
//   uint256 public n; // slot 1

//   function delegatecallSetN(address _b, uint256 _n) public {
//     _b.delegatecall(bytes4(keccak256("setN(uint256)")), _n);
//   }
// }

// contract B {
//   uint256 public n; // slot 0
//   address public owner; // slot 1

//   function setN(uint256 _n) public {
//     n = _n;
//     owner = msg.sender;
//   }
// }
