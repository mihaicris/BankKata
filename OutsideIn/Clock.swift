//
//  Clock.swift
//  OutsideIn
//
//  Created by Mihai Cristescu on 01/05/2018.
//  Copyright © 2018 Mihai Cristescu. All rights reserved.
//

import Foundation

class Clock {

    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        return dateFormatter
    }()

    func todayAsString() -> String {
        let date = today()
        return dateFormatter.string(from: date)
    }

    func today() -> Date {
        return Date()
    }
}
