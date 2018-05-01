//
//  TransactionRepository.swift
//  OutsideInTests
//
//  Created by Mihai Cristescu on 01/05/2018.
//  Copyright © 2018 Mihai Cristescu. All rights reserved.
//

import XCTest
@testable import OutsideIn

class TransactionRepositoryTests: XCTestCase {

    let kToday = "12/05/2015"

    private var transactionRepository: TransactionRepository!
    private var clockMock: ClockMock!

    override func setUp() {
        super.setUp()
        clockMock = ClockMock()
        clockMock.todayAsStringResponse = kToday
        transactionRepository = TransactionRepository(clock: clockMock)
    }

    func test_TransactionRepository_should_create_and_store_a_deposit_transaction() {
        transactionRepository.addDeposit(100)
        let transactions = transactionRepository.allTransactions()
        XCTAssertTrue(transactions.count == 1)
        XCTAssertTrue(transactions[0] == Transaction(dateString: kToday, amount: 100))
    }

    func test_TransactionRepository_should_create_and_store_a_withdrawal_transaction() {
        transactionRepository.addWithdrawal(500)
        let transactions = transactionRepository.allTransactions()
        XCTAssertTrue(transactions.count == 1)
        XCTAssertTrue(transactions[0] == Transaction(dateString: kToday, amount: -500))
    }

}

class ClockMock: Clock {
    var todayAsStringResponse: String = ""

    override func todayAsString() -> String {
        return todayAsStringResponse
    }
}
