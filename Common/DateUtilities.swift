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

public extension Date{
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
    
    func numberOfDaysToDate(dateToCompare: Date) -> Int? {
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: self)
        let date2 = calendar.startOfDay(for: dateToCompare)
        let unitFlags = Set<Calendar.Component>([.day])
        let components = calendar.dateComponents(unitFlags, from: date1, to: date2)
        return components.day
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

public func getDateWith(hour:Int? = nil, day: Int, month: Int, year: Int) -> Date? {
    let calendar = Calendar.current
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day
    components.hour = hour
    return calendar.date(from: components)
}
