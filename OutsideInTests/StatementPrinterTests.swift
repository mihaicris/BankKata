//
//  StatementPrinterTests.swift
//  OutsideInTests
//
//  Created by Mihai Cristescu on 01/05/2018.
//  Copyright © 2018 Mihai Cristescu. All rights reserved.
//

import XCTest
@testable import OutsideIn

class StatementPrinterTests: XCTestCase {

    private let kStatementHeader = "DATE | AMOUNT | BALANCE"
    private let consoleMock = ConsoleMock()
    private var statementPrinter: StatementPrinter!

    override func setUp() {
        super.setUp()
        statementPrinter = StatementPrinter(console: consoleMock)
    }
    
    func test_statement_printer_should_always_print_the_header() {
        statementPrinter.print(transactions: [])
        consoleMock.verifyPrintLinesInOrder([kStatementHeader])
    }

    func test_statement_printer_should_print_transactions_in_cronological_order() {
        let transactions = [
            Transaction(dateString: "01/04/2014", amount: 1000),
            Transaction(dateString: "02/04/2014", amount: -100),
            Transaction(dateString: "10/04/2014", amount: 500)
        ]

        statementPrinter.print(transactions: transactions)
        consoleMock.verifyPrintLinesInOrder([
            kStatementHeader,
            "10/04/2014 | 500.00 | 1400.00",
            "02/04/2014 | -100.00 | 900.00",
            "01/04/2014 | 1000.00 | 1000.00"])
    }

}
