// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Wallet {
    // * Owner of the Current Account
    address public owner;
    // * Map of all available balances
    mapping(address => uint256) public balances;

    constructor() {
        owner = msg.sender;
    }

    // * Transaction Struct
    struct Transaction {
        address sender;
        address recipient;
        uint amount;
        string message;
        uint256 timestamp;
    }

    Transaction[] transactions;

    event Transfer(
        address sender,
        address recipient,
        uint256 amount,
        string message
    );

    // * Transfer Ethers
    function transfer(
        address recipient,
        uint amount,
        string memory message
    ) public returns (bool) {
        require(amount > 0, "Transfer amount must be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        transactions.push(
            Transaction(msg.sender, recipient, amount, message, block.timestamp)
        );
        emit Transfer(msg.sender, recipient, amount, message);
        return true;
    }

    function getAllMySentTransactions()
        public
        view
        returns (Transaction[] memory)
    {
        return transactions;
    }
}
