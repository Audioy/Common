//
//  Date+ExtensionsTests.swift
//  CommonTests
//
//  Created by John Neumann on 20/10/2018.
//  Copyright © 2018 Audioy. All rights reserved.
//

import XCTest

class DateExtensionsTests: XCTestCase {

    private let laterDate = Date.with(day: 20, month: 10, year: 2018, hour: 12, minute: 03, second: 14)! // Saturday
}

// String Builder
extension DateExtensionsTests {
    // No Threshold
    func testStringBuilderWithNoThresholdForDateAWeekOrOlder() {
        let earlierDate = laterDate.removing(numberOfDays: 7) // Saturday
        let dateString = Date
            .StringBuilder(for: earlierDate)
            .comparedToLaterDate(laterDate)
            .build()
        XCTAssertEqual(dateString, "on 13/10/2018 at 12:03:14")
    }

    func testStringBuilderWithNoThresholdForDateLessThanAWeekButMoreThanADay() {
        let earlierDate = laterDate.removing(numberOfDays: 5) // Monday
        let dateString = Date
            .StringBuilder(for: earlierDate)
            .comparedToLaterDate(laterDate)
            .build()
        XCTAssertEqual(dateString, "on Monday at 12:03:14")
    }

    func testStringBuilderWithNoThresholdForDateYesterday() {
        let earlierDate = laterDate.removing(numberOfDays: 1) // Yesterday
        let dateString = Date
            .StringBuilder(for: earlierDate)
            .comparedToLaterDate(laterDate)
            .build()
        XCTAssertEqual(dateString, "yesterday at 12:03:14")
    }

    func testStringBuilderWithNoThresholdForDateToday() {
        let earlierDate = laterDate.removing(numberOfDays: 0) // Today
        let dateString = Date
            .StringBuilder(for: earlierDate)
            .comparedToLaterDate(laterDate)
            .build()
        XCTAssertEqual(dateString, "just now")
    }

    // Threshold - No change to output
    func testStringBuilderWithThresholdForDateToday() {
        let earlierDate = laterDate
        let dateString = Date
            .StringBuilder(for: earlierDate)
            .comparedToLaterDate(laterDate)
            .withThreshold(.hour, maxValue: 3)
            .build()
        XCTAssertEqual(dateString, "just now")
    }

    func testStringBuilderWithThresholdForDateAWeekOrOlder() {
        let earlierDate = laterDate.removing(numberOfDays: 7) // Saturday
        let dateString = Date
            .StringBuilder(for: earlierDate)
            .comparedToLaterDate(laterDate)
            .withThreshold(.hour, maxValue: 3)
            .build()
        XCTAssertEqual(dateString, "on 13/10/2018 at 12:03:14")
    }

    func testStringBuilderWithThresholdForDateLessThanAWeekButMoreThanADay() {
        let earlierDate = laterDate.removing(numberOfDays: 5) // Monday
        let dateString = Date
            .StringBuilder(for: earlierDate)
            .comparedToLaterDate(laterDate)
            .withThreshold(.hour, maxValue: 3)
            .build()
        XCTAssertEqual(dateString, "on Monday at 12:03:14")
    }

    func testStringBuilderWithThresholdForDateYesterday() {
        let earlierDate = laterDate.removing(numberOfDays: 1) // Yesterday
        let dateString = Date
            .StringBuilder(for: earlierDate)
            .comparedToLaterDate(laterDate)
            .withThreshold(.hour, maxValue: 3)
            .build()
        XCTAssertEqual(dateString, "yesterday at 12:03:14")
    }

    // Threshold - Seconds
    func testStringBuilderWithThresholdForDateTodayWithinSecondOfThreshold() {
        let earlierDate = laterDate.removing(numberOfDays: 0).removing(hour: 0, minute: 0, second: 1) // Today
        let dateString = Date
            .StringBuilder(for: earlierDate)
            .comparedToLaterDate(laterDate)
            .withThreshold(.second, maxValue: 2)
            .build()
        XCTAssertEqual(dateString, "1 second ago")
    }

    func testStringBuilderWithThresholdForDateTodayWithinSecondsOfThreshold() {
        let earlierDate = laterDate.removing(numberOfDays: 0).removing(hour: 0, minute: 0, second: 14) // Today
        let dateString = Date
            .StringBuilder(for: earlierDate)
            .comparedToLaterDate(laterDate)
            .withThreshold(.second, maxValue:15)
            .build()
        XCTAssertEqual(dateString, "14 seconds ago")
    }

    func testStringBuilderWithThresholdForDateTodayLaterThanSecondThreshold() {
        let earlierDate = laterDate.removing(numberOfDays: 0).removing(hour: 0, minute: 0, second: 14) // Today
        let dateString = Date
            .StringBuilder(for: earlierDate)
            .comparedToLaterDate(laterDate)
            .withThreshold(.second, maxValue: 14)
            .build()
        XCTAssertEqual(dateString, "today at 12:03:00")
    }

    // Threshold - Minutes
    func testStringBuilderWithThresholdForDateTodayWithinSecondsOfMinuteOfThreshold() {
        let earlierDate = laterDate.removing(numberOfDays: 0).removing(hour: 0, minute: 0, second: 14) // Today
        let dateString = Date
            .StringBuilder(for: earlierDate)
            .comparedToLaterDate(laterDate)
            .withThreshold(.minute, maxValue: 1)
            .build()
        XCTAssertEqual(dateString, "14 seconds ago")
    }

    func testStringBuilderWithThresholdForDateTodayWithinMinuteOfThreshold() {
        let earlierDate = laterDate.removing(numberOfDays: 0).removing(hour: 0, minute: 1, second: 14) // Today
        let dateString = Date
            .StringBuilder(for: earlierDate)
            .comparedToLaterDate(laterDate)
            .withThreshold(.minute, maxValue: 2)
            .build()
        XCTAssertEqual(dateString, "1 minute ago")
    }

    func testStringBuilderWithThresholdForDateTodayWithinMinutesOfThreshold() {
        let earlierDate = laterDate.removing(numberOfDays: 0).removing(hour: 0, minute: 2, second: 14) // Today
        let dateString = Date
            .StringBuilder(for: earlierDate)
            .comparedToLaterDate(laterDate)
            .withThreshold(.minute, maxValue: 3)
            .build()
        XCTAssertEqual(dateString, "2 minutes ago")
    }

    func testStringBuilderWithThresholdForDateTodayLaterThanMinuteThreshold() {
        let earlierDate = laterDate.removing(numberOfDays: 0).removing(hour: 0, minute: 3, second: 2) // Today
        let dateString = Date
            .StringBuilder(for: earlierDate)
            .comparedToLaterDate(laterDate)
            .withThreshold(.minute, maxValue: 3)
            .build()
        XCTAssertEqual(dateString, "today at 12:00:12")
    }

    // Threshold - Hours
    func testStringBuilderWithThresholdForDateTodayWithinSecondsOfHourOfThreshold() {
        let earlierDate = laterDate.removing(numberOfDays: 0).removing(hour: 0, minute: 0, second: 14) // Today
        let dateString = Date
            .StringBuilder(for: earlierDate)
            .comparedToLaterDate(laterDate)
            .withThreshold(.hour, maxValue: 3)
            .build()
        XCTAssertEqual(dateString, "14 seconds ago")
    }

    func testStringBuilderWithThresholdForDateTodayWithinSecondsAndMinutesOfHourOfThreshold() {
        let earlierDate = laterDate.removing(numberOfDays: 0).removing(hour: 0, minute: 2, second: 14) // Today
        let dateString = Date
            .StringBuilder(for: earlierDate)
            .comparedToLaterDate(laterDate)
            .withThreshold(.hour, maxValue: 3)
            .build()
        XCTAssertEqual(dateString, "2 minutes ago")
    }

    func testStringBuilderWithThresholdForDateTodayWithinHourOnlyOfThreshold() {
        let earlierDate = laterDate.removing(numberOfDays: 0).removing(hour: 1, minute: 0, second: 59) // Today
        let dateString = Date
            .StringBuilder(for: earlierDate)
            .comparedToLaterDate(laterDate)
            .withThreshold(.hour, maxValue: 3)
            .build()
        XCTAssertEqual(dateString, "1 hour ago")
    }

    func testStringBuilderWithThresholdForDateTodayWithinHourOfThreshold() {
        let earlierDate = laterDate.removing(numberOfDays: 0).removing(hour: 1, minute: 2, second: 14) // Today
        let dateString = Date
            .StringBuilder(for: earlierDate)
            .comparedToLaterDate(laterDate)
            .withThreshold(.hour, maxValue: 3)
            .build()
        XCTAssertEqual(dateString, "1 hour 2 minutes ago")
    }

    func testStringBuilderWithThresholdForDateTodayWithinHoursOfThreshold() {
        let earlierDate = laterDate.removing(numberOfDays: 0).removing(hour: 2, minute: 2, second: 14) // Today
        let dateString = Date
            .StringBuilder(for: earlierDate)
            .comparedToLaterDate(laterDate)
            .withThreshold(.hour, maxValue: 3)
            .build()
        XCTAssertEqual(dateString, "2 hours 2 minutes ago")
    }

    func testStringBuilderWithThresholdForDateTodayLaterThanHourThreshold() {
        let earlierDate = laterDate.removing(numberOfDays: 0).removing(hour: 3, minute: 0, second: 0) // Today
        let dateString = Date
            .StringBuilder(for: earlierDate)
            .comparedToLaterDate(laterDate)
            .withThreshold(.hour, maxValue: 3)
            .build()
        XCTAssertEqual(dateString, "today at 09:03:14")
    }
}

// Time Elapsed
extension DateExtensionsTests {
    func testTimeElapsedSeconds() {
        let earlierDate = laterDate.removing(hour: 0, minute: 0, second: 2)
        let timeElapsed = Date.timeElapsed(between: earlierDate, and: laterDate)
        XCTAssertEqual(timeElapsed, "2s")
    }

    func testTimeElapsedMinutesSeconds() {
        let earlierDate = laterDate.removing(hour: 0, minute: 12, second: 23)
        let timeElapsed = Date.timeElapsed(between: earlierDate, and: laterDate)
        XCTAssertEqual(timeElapsed, "12m23s")
    }

    func testTimeElapsedHoursMinutesSeconds() {
        let earlierDate = laterDate.removing(hour: 3, minute: 12, second: 23)
        let timeElapsed = Date.timeElapsed(between: earlierDate, and: laterDate)
        XCTAssertEqual(timeElapsed, "3h12m23s")
    }

    func testTimeElapsedDaysHours() {
        let earlierDate = laterDate.removing(numberOfDays: 5).removing(hour: 3, minute: 0, second: 0)
        let timeElapsed = Date.timeElapsed(between: earlierDate, and: laterDate)
        XCTAssertEqual(timeElapsed, "5d3h")
    }

    func testTimeElapsedDaysHoursSeconds() {
        let earlierDate = laterDate.removing(numberOfDays: 5).removing(hour: 3, minute: 0, second: 23)
        let timeElapsed = Date.timeElapsed(between: earlierDate, and: laterDate)
        XCTAssertEqual(timeElapsed, "5d3h0m23s")
    }

    func testTimeElapsedDaysHoursMinutesSeconds() {
        let earlierDate = laterDate.removing(numberOfDays: 5).removing(hour: 3, minute: 12, second: 23)
        let timeElapsed = Date.timeElapsed(between: earlierDate, and: laterDate)
        XCTAssertEqual(timeElapsed, "5d3h12m23s")
    }
}

private extension Date {
    func removing(numberOfDays: Int) -> Date {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second], from: self)
        return Date.with(day: components.day! - numberOfDays, month: components.month!, year: components.year!, hour: components.hour!, minute: components.minute!, second: components.second!)!
    }

    func removing(hour: Int, minute: Int, second: Int) -> Date {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second], from: self)
        return Date.with(day: components.day!, month: components.month!, year: components.year!, hour: components.hour! - hour, minute: components.minute! - minute, second: components.second! - second)!
    }
}
