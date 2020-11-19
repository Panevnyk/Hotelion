//
//  Calendar+Extensions.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 24.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation

extension Calendar {
    static let GMT: Calendar = {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar
    }()
}
