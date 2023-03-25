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
        uint256 amount;
        string message;
        uint256 timestamp;
        address initiator;
    }

    Transaction[] public transactions;

    event Transfer(
        address sender,
        address recipient,
        uint256 amount,
        string message,
        uint256 timestamp,
        address initiator
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
            Transaction(
                msg.sender,
                recipient,
                amount,
                message,
                block.timestamp,
                msg.sender
            )
        );
        emit Transfer(
            msg.sender,
            recipient,
            amount,
            message,
            block.timestamp,
            msg.sender
        );
        return true;
    }

    // function findMySentTransactions(Transaction  trx) public view {
    //     Transaction[] memory tempList;
    //     for (uint i = 0; i < transactions.length; i++) {
    //         if (transactions[i] == trx.initiator) {
    //             tempList.push(trx);
    //         }
    //     }
    //     return false;
    // }

    function getAllMySentTransactions()
        public
        view
        returns (Transaction[] memory)
    {
        return transactions;
    }
}
