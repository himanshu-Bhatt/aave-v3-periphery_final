// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.8.10;

// with mint
contract DummyERC20Impl {
    uint256 t;
    mapping (address => uint256) b;
    mapping (address => mapping (address => uint256)) a;

    string public name;
    string public symbol;
    uint public decimals;

    function myAddress() public returns (address) {assembly { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00450000, 1037618708549) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00450001, 0) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00450002, 0) }
        return address(this);
    }

    function add(uint a, uint b) internal pure returns (uint256) {assembly { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00430000, 1037618708547) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00430001, 2) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00430003, 5) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00436001, b) }
        uint c = a +b;
        require (c >= a);
        return c;
    }
    function sub(uint a, uint b) internal pure returns (uint256) {assembly { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00440000, 1037618708548) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00440001, 2) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00440003, 5) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00446001, b) }
        require (a>=b);
        return a-b;
    }

    function totalSupply() external view returns (uint256) {
        return t;
    }
    function balanceOf(address account) external view returns (uint256) {
        return b[account];
    }
    function transfer(address recipient, uint256 amount) external returns (bool) {
        b[msg.sender] = sub(b[msg.sender], amount);
        b[recipient] = add(b[recipient], amount);
        return true;
    }
    function allowance(address owner, address spender) external view returns (uint256) {
        return a[owner][spender];
    }
    function approve(address spender, uint256 amount) external returns (bool) {
        a[msg.sender][spender] = amount;
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool) {
        b[sender] = sub(b[sender], amount);
        b[recipient] = add(b[recipient], amount);
        a[sender][msg.sender] = sub(a[sender][msg.sender], amount);
        return true;
    }
}