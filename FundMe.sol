
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
import {PriceConverter} from "./PriceConverter.sol";
contract FundMe{
    uint256 public minusd=5e18;
    address[] public funders;
    mapping(address => uint256) addressToAmountFunded;
    using PriceConverter for uint256;
    function fund() public payable {
        require(msg.value.getConversionRate()>=minusd,"didn't send enough eth");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender]+=msg.value;
    }
    function withdraw() public {
        for(uint256 funderIndex=0; funderIndex<funders.length;funderIndex++){
            address funder=funders[funderIndex];
            addressToAmountFunded[funder]=0;
      }
      funders =new address[](0);
      payable( msg.sender).transfer(address(this).balance);
    }
}