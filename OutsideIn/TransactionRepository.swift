//
//  TransationRepository.swift
//  OutsideIn
//
//  Created by Mihai Cristescu on 01/05/2018.
//  Copyright © 2018 Mihai Cristescu. All rights reserved.
//

import Foundation

class TransactionRepository {
    private let clock: Clock
    private var transactions: [Transaction] = []

    init(clock: Clock) {
        self.clock = clock
    }
    
    func addDeposit(_ amount: Int) {
        let dateString = self.clock.todayAsString()
        let deposit = Transaction(dateString: dateString, amount: amount)
        transactions.append(deposit)
    }

    func addWithdrawal(_ amount: Int) {
        let dateString = self.clock.todayAsString()
        let withdraw = Transaction(dateString: dateString, amount: -amount)
        transactions.append(withdraw)
    }

    func allTransactions() -> [Transaction] {
        let transactionsConstant = self.transactions
        return transactionsConstant
    }

}
