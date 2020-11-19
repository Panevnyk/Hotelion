//
//  Date+Extensions.swift
//  HotelionDomain
//
//  Created by Vladyslav Panevnyk on 10.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation

extension Date {
    var startOfDay: Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let comp: DateComponents = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: comp)!
    }

    var startOfMonth: Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let comp: DateComponents = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: comp)!
    }

    var endOfMonth: Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        var comps2 = DateComponents()
        comps2.month = 1
        comps2.day = -1
        return calendar.date(byAdding: comps2, to: startOfMonth)!
    }

    var startOfYear: Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let comp: DateComponents = calendar.dateComponents([.year], from: self)
        return calendar.date(from: comp)!
    }

    var endOfYear: Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        var comps2 = DateComponents()
        comps2.year = 1
        comps2.day = -1
        return calendar.date(byAdding: comps2, to: startOfYear)!
    }
}
