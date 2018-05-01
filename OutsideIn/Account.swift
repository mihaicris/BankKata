//
//  Account.swift
//  OutsideIn
//
//  Created by Mihai Cristescu on 01/05/2018.
//  Copyright © 2018 Mihai Cristescu. All rights reserved.
//

import Foundation

class Account {

    let transactionRepository: TransactionRepository
    let statementPrinter: StatementPrinter

    init(transactionRepository: TransactionRepository, statementPrinter: StatementPrinter) {
        self.transactionRepository = transactionRepository
        self.statementPrinter = statementPrinter
    }

    func deposit(_ amount: Int) {
        transactionRepository.addDeposit(amount)
    }

    func withdraw(_ amount: Int) {
        transactionRepository.addWithdrawal(amount)
    }

    func printStatement() {
        statementPrinter.print(transactions: transactionRepository.allTransactions())
    }
}
