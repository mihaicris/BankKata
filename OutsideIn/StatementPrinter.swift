//
//  StatementPrinter.swift
//  OutsideIn
//
//  Created by Mihai Cristescu on 01/05/2018.
//  Copyright © 2018 Mihai Cristescu. All rights reserved.
//

import Foundation

class StatementPrinter {

    let console: Console
    var runningBalance: Int = 0

    let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US")
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.roundingMode = .up
        numberFormatter.groupingSeparator = ""
        return numberFormatter
    }()

    init(console: Console) {
        self.console = console
    }

    func print(transactions: [Transaction]) {
        console.printLine(text: "DATE | AMOUNT | BALANCE")
        printStatementLines(transactions)
    }

    private func printStatementLines(_ transactions: [Transaction]) {
        let statementLines: [String] = transactions
            .map { statementLine(transaction: $0) }
            .reversed()
        statementLines.forEach { console.printLine(text: $0)}
    }

    private func getFormattedAmmount(from value: Int) -> String {
        return numberFormatter.string(from: NSNumber(integerLiteral: value))!
    }

    private func statementLine(transaction: Transaction) -> String {
        runningBalance += transaction.amount
        return "\(transaction.dateString) | \(getFormattedAmmount(from: transaction.amount)) | \(getFormattedAmmount(from: runningBalance))"
    }
}
