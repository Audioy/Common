//
//  DateUtilities.swift
//  Common
//
//  Created by Audioy Ltd on 10/12/2017.
//  Copyright © 2017 Audioy. All rights reserved.
//

import Foundation

let UTCDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Set this locale to avoid 24/12hr bugs
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC") // Always have the server store the date as UTC
    
    return dateFormatter
}()

let localDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Set this locale to avoid 24/12hr bugs
    dateFormatter.timeZone = TimeZone.current // TimeZone.ReferenceType.local // For local use
    
    return dateFormatter
}()

public extension Date {
    public class StringBuilder {

        private var thresholdComponent: Calendar.Component? = nil
        private var thresholdValue: Int? = nil
        private let fromDate: Date
        private var toDate: Date?

        public func withThreshold(_ component: Calendar.Component, maxValue: Int) -> StringBuilder {
            guard (component == .hour && maxValue <= 24)
                || (component == .minute && maxValue <= 60)
                || (component == .second && maxValue <= 60)
                else {
                    return self
            }

            thresholdComponent = component
            thresholdValue = maxValue
            return self
        }

        public func comparedToLaterDate(_ date: Date) -> StringBuilder {
            toDate = date
            return self
        }

        public func build() -> String {
            let calendar = Calendar.current

            // To get the number of days between 2 dates which are less than 24 hours apart but on different days, we have to use dateComponents rather than dates themselves
            let toDate = self.toDate ?? Date()
            let from = calendar.dateComponents(Set<Calendar.Component>([.day, .month, .year]), from: fromDate)
            let to = calendar.dateComponents(Set<Calendar.Component>([.day, .month, .year]), from: toDate)
            let delta = calendar.dateComponents(Set<Calendar.Component>([.day, .month, .year]), from: from, to: to)

            let components = calendar.dateComponents(Set<Calendar.Component>([.hour, .minute, .second]), from: fromDate, to: toDate)

            guard let deltaDay = delta.day else {
                return "Couldn't calculate the date"
            }

            switch deltaDay {
            case 2..<7:
                return stringForWeekDay
            case 1:
                return stringForYesterday
            case 0:
                return stringForToday(withComponents: components)
            default:
                return stringForDefault
            }
        }

        public init(for date: Date) {
            fromDate = date
        }

        private var stringForWeekDay: String {
            return "On " + fromDate.dayOfTheWeek + " at " + fromDate.time
        }

        private var stringForYesterday: String {
            return "Yesterday at " + fromDate.time
        }

        private func stringForToday(withComponents components: DateComponents) -> String {

            if components.hour == 0 && components.minute == 0 && components.second == 0 {
                return "Just now"
            }

            guard
                let thresholdComponent = thresholdComponent,
                let thresholdValue = thresholdValue,
                let hours = components.hour,
                let minutes = components.minute,
                let seconds = components.second
                else {
                    return "Today at " + fromDate.time
            }

            var withinThreshold = false
            switch thresholdComponent {
            case .hour:
                if hours < thresholdValue { withinThreshold = true }
            case .minute:
                if minutes < thresholdValue && hours == 0 { withinThreshold = true }
            case .second:
                if seconds < thresholdValue && hours == 0 && minutes == 0 { withinThreshold = true }
            default:
                break
            }

            guard withinThreshold else {
                return "Today at " + fromDate.time
            }

            switch thresholdComponent {
            case .second:
                return stringFor(.second, withValue: seconds) + " ago"
            case .minute:
                return (minutes > 0 ? stringFor(.minute, withValue: minutes) : stringFor(.second, withValue: seconds)) + " ago"
            case .hour:
                if hours == 0 && minutes == 0 {
                    return stringFor(.second, withValue: seconds) + " ago"
                }
                else if hours == 0 && minutes > 0 {
                    return stringFor(.minute, withValue: minutes) + " ago"
                }
                else if hours > 0 && minutes == 0{
                    return stringFor(.hour, withValue: hours) + " ago"
                }
                else if hours > 0 && minutes > 0 {
                    return stringFor(.hour, withValue: hours) + " " + stringFor(.minute, withValue: minutes) + " ago"
                }
            default:
                break
            }
            return ""
        }

        private var stringForDefault: String {
            return "On " + fromDate.date + " at " + fromDate.time
        }

        private func stringFor(_ component: Calendar.Component, withValue value: Int) -> String {
            let valueString = String(value)
            let componentString: String
            switch value {
            case 1:
                switch component {
                case .year: componentString = "year"
                case .month: componentString = "month"
                case .day: componentString = "day"
                case .hour: componentString = "hour"
                case .minute: componentString = "minute"
                case .second: componentString = "second"
                default: componentString = ""
                }
            default:
                switch component {
                case .year: componentString = " years"
                case .month: componentString = "months"
                case .day: componentString = "days"
                case .hour: componentString = "hours"
                case .minute: componentString = "minutes"
                case .second: componentString = "seconds"
                default: componentString = ""
                }
            }
            return valueString + " " + componentString
        }
    }
}

public extension Date {
    var asUTCString: String {
        return UTCDateFormatter.string(from: self)
    }
    
    var asLocalString: String {
        return localDateFormatter.string(from: self)
    }
    
    var numberOfDaysToNow: Int?{
        return self.numberOfDaysToDate(dateToCompare: Date())
    }
    
    var dayOfTheWeek: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }

    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }

    var time: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Set this locale to avoid 24/12hr bugs
        return dateFormatter.string(from: self)
    }
    
    func numberOfDaysToDate(dateToCompare: Date) -> Int? {
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: self)
        let date2 = calendar.startOfDay(for: dateToCompare)
        let unitFlags = Set<Calendar.Component>([.day])
        let components = calendar.dateComponents(unitFlags, from: date1, to: date2)
        return components.day
    }

    static func numberOfDays(between startDate: Date, and endDate: Date) -> Int? {
        let calendar = NSCalendar.current

        let date1 = calendar.startOfDay(for: startDate)
        let date2 = calendar.startOfDay(for: endDate)

        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day
    }

    static func with(day: Int, month: Int, year: Int, hour:Int? = nil, minute:Int? = nil, second: Int? = nil) -> Date? {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        return calendar.date(from: components)
    }

    static func timeElapsed(between startDate: Date, and endDate: Date) -> String {
        let calendar = NSCalendar.current

        let components = calendar.dateComponents([.day, .hour, .minute, .second], from: startDate, to: endDate)
        var returnedString = ""
        if let second = components.second, second > 0 {
            returnedString.insert(contentsOf: "\(second)" + "s", at: returnedString.startIndex)
        }
        if let minute = components.minute, (returnedString.count > 0 || minute > 0) {
            returnedString.insert(contentsOf: "\(minute)" + "m", at: returnedString.startIndex)
        }
        if let hour = components.hour, (returnedString.count > 0 || hour > 0) {
            returnedString.insert(contentsOf: "\(hour)" + "h", at: returnedString.startIndex)
        }
        if let day = components.day, (returnedString.count > 0 || day > 0) {
            returnedString.insert(contentsOf: "\(day)" + "d", at: returnedString.startIndex)
        }

        return returnedString
    }
}

public extension String{
    var asUTCDate: Date?{
        return UTCDateFormatter.date(from: self)
    }
    
    // Only use if the string was created with the local timezone, not with UTC, otherwise the result won't be correct
    var asLocalDate: Date?{
        return localDateFormatter.date(from: self)
    }
}
