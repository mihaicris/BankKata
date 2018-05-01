//
//  OutsideInTests.swift
//  OutsideInTests
//
//  Created by Mihai Cristescu on 01/05/2018.
//  Copyright © 2018 Mihai Cristescu. All rights reserved.
//

import XCTest
@testable import OutsideIn

class PrintStatementFeature: XCTestCase {
    
    private var consoleMock: ConsoleMock!
    private var clockMock: ClockMock!
    private var account: Account!

    override func setUp() {
        consoleMock = ConsoleMock()
        clockMock = ClockMock()

        let transactionRepository = TransactionRepository(clock: clockMock)
        let statementPrinter = StatementPrinter(console: consoleMock)
        account = Account(transactionRepository: transactionRepository, statementPrinter: statementPrinter)
    }

    func test_print_statement_containing_all_transactions() {

        clockMock.todayAsStringResponse = "01/04/2014"
        account.deposit(1000)

        clockMock.todayAsStringResponse = "02/04/2014"
        account.withdraw(100)

        clockMock.todayAsStringResponse = "10/04/2014"
        account.deposit(500)

        account.printStatement()

        consoleMock.verifyPrintLinesInOrder([
            "DATE | AMOUNT | BALANCE",
            "10/04/2014 | 500.00 | 1400.00",
            "02/04/2014 | -100.00 | 900.00",
            "01/04/2014 | 1000.00 | 1000.00"])
    }
}

class ConsoleMock: Console {

    var numberOfCalls: Int = 0
    var recordedLines: [String] = []

    func verifyPrintLinesInOrder(_ lines: [String]) {
        XCTAssert(numberOfCalls == lines.count, "Expected \(numberOfCalls) calls, got \(lines.count)")
        XCTAssert(lines == recordedLines, "Lines are not printed in order. Expected \(lines.description), got \(recordedLines.description)")
    }

    override func printLine(text: String) {
        numberOfCalls += 1
        recordedLines.append(text)
    }
}
