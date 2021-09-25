// SPDX-License-Idenntifier: MIT

pragma solidity >= 0.6.6 <0.9.0;

import "./SimpleStorage.sol";

contract StorageFactory{
    
    SimpleStorage[] public storages;
    
    function DeployStorage() public {
        SimpleStorage ss = new SimpleStorage();
        storages.push(ss);
    }
    
    function invokeStorageStore(uint256 _id, uint256 _storageNumber) public{
        SimpleStorage(address(storages[_id])).store(_storageNumber);
    }
    
    function getStorageNumber(uint256 _address) public view returns(uint256){
        return SimpleStorage(address(storages[_address])).retrieve();
    }
}
