//
//  AccountTests.swift
//  OutsideInTests
//
//  Created by Mihai Cristescu on 01/05/2018.
//  Copyright © 2018 Mihai Cristescu. All rights reserved.
//

import XCTest
@testable import OutsideIn

class AccountTests: XCTestCase {

    private var consoleMock: ConsoleMock!
    private var transactionRepositoryMock: TransactionRepositoryMock!
    private var statementPrinterMock: StatementPrinterMock!
    private var clockMock: ClockMock!
    private var account: Account!

    override func setUp() {
        super.setUp()

        consoleMock = ConsoleMock()
        clockMock = ClockMock()
        transactionRepositoryMock = TransactionRepositoryMock(clock: clockMock)
        statementPrinterMock = StatementPrinterMock(console: consoleMock)

        account = Account(transactionRepository: transactionRepositoryMock,
                          statementPrinter: statementPrinterMock)
    }

    func test_account_should_store_a_deposit_transaction() {
        account.deposit(100)
        transactionRepositoryMock.verifyAddDeposit(100)
    }

    func test_account_should_store_a_withdrawal_transaction() {
        account.withdraw(100)
        transactionRepositoryMock.verifyWithdraw(100)
    }

    func test_account_should_print_a_statement() {
        let transactions = [Transaction(dateString: "12/01/2018", amount: 100)]
        transactionRepositoryMock.allTransactionsResponse = transactions
        account.printStatement()
        statementPrinterMock.verifyCalledPrint(transactions)
    }

}

class TransactionRepositoryMock: TransactionRepository {

    var addDepositCalls: Int = 0
    var withdrawCalls: Int = 0

    var depositAmount: Int = 0
    var withdrawAmount: Int = 0

    var allTransactionsResponse: [Transaction] = []

    func verifyAddDeposit(_ amount: Int) {
        XCTAssert(self.depositAmount == amount)
    }

    func verifyWithdraw(_ amount: Int) {
        XCTAssert(self.withdrawAmount == amount)
    }

    override func addDeposit(_ amount: Int) {
        addDepositCalls += 1
        self.depositAmount = amount
    }

    override func addWithdrawal(_ amount: Int) {
        withdrawCalls += 1
        self.withdrawAmount = amount
    }

    override func allTransactions() -> [Transaction] {
        return allTransactionsResponse
    }

}

class StatementPrinterMock: StatementPrinter {

    var numberOfCallsPrint: Int = 0
    var transactions: [Transaction] = []

    func verifyCalledPrint(_ transactions: [Transaction]) {
        XCTAssert(self.transactions == transactions)
    }

    override func print(transactions: [Transaction]) {
        numberOfCallsPrint += 1
        self.transactions = transactions
    }
}
