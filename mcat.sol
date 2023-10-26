
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MztacatCommunity {
    string public name = "MztacatCommunity";
    string public symbol = "MZT";
    uint8 public decimals = 18;
    uint256 public totalSupply = 1000000 * (10 ** uint256(decimals));
    address public owner;
   
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowances;
   
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
   
    constructor() {
        owner = msg.sender;
        balances[owner] = totalSupply;
    }
   
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function.");
        _;
    }
   
    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }
   
    function transfer(address recipient, uint256 amount) public returns (bool) {
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require(amount <= balances[msg.sender], "ERC20: transfer amount exceeds balance");
       
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
       
        emit Transfer(msg.sender, recipient, amount);
       
        return true;
    }
   
    function approve(address spender, uint256 amount) public returns (bool) {
        allowances[msg.sender][spender] = amount;
       
        emit Approval(msg.sender, spender, amount);
       
        return true;
    }
   
    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require(amount <= balances[sender], "ERC20: transfer amount exceeds balance");
        require(amount <= allowances[sender][msg.sender], "ERC20: transfer amount exceeds allowance");
       
        balances[sender] -= amount;
        balances[recipient] += amount;
        allowances[sender][msg.sender] -= amount;
       
        emit Transfer(sender, recipient, amount);
       
        return true;
    }
   
    function allowance(address account, address spender) public view returns (uint256) {
        return allowances[account][spender];
    }
   
    function burn(uint256 amount) public returns (bool) {
        require(amount <= balances[msg.sender], "ERC20: burn amount exceeds balance");
       
        balances[msg.sender] -= amount;
        totalSupply -= amount;
       
        emit Transfer(msg.sender, address(0), amount);
       
        return true;
    }
   
    function mint(uint256 amount) public onlyOwner returns (bool) {
        require(totalSupply + amount <= 2**256 - 1, "ERC20: total supply exceeds uint256");
       
        balances[owner] += amount;
        totalSupply += amount;
       
        emit Transfer(address(0), owner, amount);
       
        return true;
    }
}