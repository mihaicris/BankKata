//
//  ViewController.swift
//  OutsideIn
//
//  Created by Mihai Cristescu on 01/05/2018.
//  Copyright © 2018 Mihai Cristescu. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let clock = Clock()
        let transactionRepository = TransactionRepository(clock: clock)
        let console = Console()
        let statementPrinter = StatementPrinter(console: console)
        let account = Account(transactionRepository: transactionRepository, statementPrinter: statementPrinter)

        account.deposit(1000)
        account.withdraw(400)
        account.deposit(100)

        account.printStatement()
    }

    override var representedObject: Any? {
        didSet {}
    }


}

