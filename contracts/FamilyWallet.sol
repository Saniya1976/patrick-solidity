// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract FamilyWallet {
    address public owner;
    mapping(address => uint256) public allowance;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        _onlyOwner();
        _;
    }

    function _onlyOwner() internal view {
        require(msg.sender == owner, "U are not the Owner");
    }

    modifier memberOnly() {
        _memberOnly();
        _;
    }

    function _memberOnly() internal view {
        require(allowance[msg.sender] > 0, "Not a member");
    }

    function deposit(address _member, uint256 _amount) external payable {
        require(msg.value > 0, "amount to be deposited cannot be 0");
        allowance[_member] += _amount;
    }

    function withdraw(uint256 _amount) external memberOnly {
        require(_amount <= allowance[msg.sender], "Exceeds allowance");
        require(
            _amount <= address(this).balance,
            "Insufficient contract balance"
        );
        allowance[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
    }

    function removeMember(address _member) external onlyOwner {
        allowance[_member] = 0;
    }

    function addMember() external onlyOwner {
        allowance[msg.sender] += 1;
    }

    function setAllowance(address _member, uint256 _amount) external onlyOwner {
        allowance[_member] = _amount;
    }

    function ownerWithdraw(uint256 _amount) external onlyOwner {
        require(_amount <= address(this).balance, "Not Sufficient Balance");
        payable(owner).transfer(_amount);
    }

    function checkMyBalance() external view returns (uint256) {
        return allowance[msg.sender];
    }

    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
