//
//  Date+Extensions.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 24.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation

extension Date {
    var startOfDay: Date {
        return Calendar.GMT.startOfDay(for: self)
    }

    var isSunday: Bool {
        return weekDay == 1
    }

    var isMonday: Bool {
        return weekDay == 2
    }

    var isFirstDayOfMonth: Bool {
        return day == 1
    }

    var weekDay: Int {
        let timeZone = TimeZone(secondsFromGMT: 0)!
        let component =  Calendar.GMT.dateComponents(in: timeZone, from: self)
        return component.weekday ?? 0
    }

    var day: Int {
        let timeZone = TimeZone(secondsFromGMT: 0)!
        let component =  Calendar.GMT.dateComponents(in: timeZone, from: self)
        return component.day ?? 0
    }

    var dayBefore: Date {
        return Calendar.GMT.date(byAdding: .day, value: -1, to: self)!
    }

    var dayAfter: Date {
        return Calendar.GMT.date(byAdding: .day, value: 1, to: self)!
    }

    var noon: Date {
        return Calendar.GMT.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }

    var month: Int {
        return Calendar.GMT.component(.month,  from: self)
    }

    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
