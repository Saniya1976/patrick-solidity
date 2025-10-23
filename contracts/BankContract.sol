// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract SimpleBank{
    mapping(address=>uint256) private balances;

    function withdraw(uint256 amount)external {
        require(amount<= balances[msg.sender],"not enough balance in account to be withdrawn");
        balances[msg.sender]-=amount;
        payable(msg.sender).transfer(amount);
    }
    function deposit()external payable{
        require(msg.value>0,"Deposit some valid amount");
        balances[msg.sender]+=msg.value;
    }
    function checkBal() public view returns(uint256){
        return balances[msg.sender];
    }
    function totalBalance() public view returns(uint256){
        return address(this).balance;
    }
}