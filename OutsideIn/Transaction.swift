//
//  Transaction.swift
//  OutsideIn
//
//  Created by Mihai Cristescu on 01/05/2018.
//  Copyright © 2018 Mihai Cristescu. All rights reserved.
//

import Foundation

class Transaction {
    let dateString: String
    let amount: Int

    init(dateString: String, amount: Int) {
        self.dateString = dateString
        self.amount = amount
    }
}

extension Transaction: Equatable {
    static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.dateString == rhs.dateString && lhs.amount == rhs.amount
    }

}
