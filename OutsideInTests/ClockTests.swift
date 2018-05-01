//
//  ClockTests.swift
//  OutsideInTests
//
//  Created by Mihai Cristescu on 01/05/2018.
//  Copyright © 2018 Mihai Cristescu. All rights reserved.
//

import XCTest
@testable import OutsideIn

class ClockTests: XCTestCase {

    let kTestableToday = "24/04/2015"
    private var clock: Clock!

    override func setUp() {
        super.setUp()
        clock = TestableClock()
    }

    func test_Clock_should_return_today_in_dd_MM_yyy_format() {
        let dateString = clock.todayAsString()
        XCTAssertEqual(dateString, kTestableToday)
    }

    private class TestableClock: Clock {
        override func today() -> Date {

            let calendar = Calendar.current
            var components = DateComponents()
            components.day = 24
            components.month = 4
            components.year = 2015
            return calendar.date(from: components)!
        }
    }

}
