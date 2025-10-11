
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract fundme{
    uint256 public minusd=5e18;
    function fund() public payable {
        require(getConversionRate(msg.value)>=minusd,"didn't send enough eth");
    }
    function getPrice() public view returns(uint256){
        AggregatorV3Interface pricefeed=AggregatorV3Interface(0x401c7c2F38131c2479a9B3f73Df199B81014697C);
        (,int256 price,,,)=pricefeed.latestRoundData();
        return uint256(price*1e10);
    }
    function getConversionRate(uint256 ethAmount)public view returns(uint256){
            uint256 ethPrice=getPrice();
            uint256 ethAmountInUSD=(ethPrice*ethAmount)/1e18;
            return  ethAmountInUSD;
    }
    function getVersion() public view returns(uint256){
        return AggregatorV3Interface(0x401c7c2F38131c2479a9B3f73Df199B81014697C).version();
    }
}