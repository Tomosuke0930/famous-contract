contract Box {
    uint256 private _value;

    function store(uint256 value) public { /*..*/ }

    function retrieve() public view returns (uint256) { /*..*/ }
}

contract BoxProxy {

     function _delegate(address implementation) internal virtual { /*..*/ }

     function getImplementationAddress() public view returns (address) { /*..*/ }

     fallback() external { /*..*/ }

     // Upgrade logic in Proxy contract
     upgradeTo(address newImpl) external {
         // Changes stored address of implementation of contract
         // at its slot in storage
     }
}