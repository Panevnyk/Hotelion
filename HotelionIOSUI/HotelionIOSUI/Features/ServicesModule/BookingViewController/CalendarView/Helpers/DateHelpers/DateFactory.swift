//
//  DateFactory.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 24.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation

struct DateFactory {
    private static let dateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "dd/MM/yyyy"
       dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)!
       return dateFormatter
    }()

    static func makeDate(_ stringDate: String) -> Date {
        return dateFormatter.date(from: stringDate)!
    }
}
