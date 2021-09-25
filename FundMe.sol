// SPDX-License-Idenntifier: MIT
pragma solidity >= 0.6.6 <0.9.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract FundMe{
    
    mapping(address => uint256) public addressToAmountFunded;
    
    function fund() public payable{
        uint256 minUsd = 50 * 10 * 18;
        require(getConversionRate(msg.value) >= minUsd, "Send more monez");
        addressToAmountFunded[msg.sender] += msg.value;
    }
    
    function getVersion() public view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
        return priceFeed.version();
    }
    
    function getPrice() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
        (,int256 answer,,,) = priceFeed.latestRoundData();
         return uint256(answer * 10000000000);
    }
    
    function getConversionRate(uint256 ethAmount) public view returns(uint256){
        uint256 ethPrice = getPrice();
        return (ethAmount * ethPrice) / 1000000000000000000;
    }
    
    function withdraw() payable public {
        msg.sender.transfer(address(this).balance);
    }
}
