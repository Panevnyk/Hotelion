//
//  DateFormatterHelper.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 25.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation

final class DateFormatterHelper {
    static let locale = Locale(identifier: "en_US")

    private static let dateFormatter = DateFormatter()

    // "MMM"
    static func mmmDateFormat(from date: Date) -> String {
        DateFormatterHelper.dateFormatter.dateFormat = "MMM"
        return string(from: date)
    }

    // "h:mm a"
    static func hmmaDateFormat(from date: Date) -> String {
        DateFormatterHelper.dateFormatter.dateFormat = "h:mm a"
        return string(from: date)
    }

    // "dd/MM/yyyy"
    static func ddMMyyyyDateFormat(from date: Date) -> String {
        DateFormatterHelper.dateFormatter.dateFormat = "dd/MM/yyyy"
        return string(from: date)
    }

    // "dd/MM/yyyy h:mm a"
    static func ddMMyyyyhmmaDateFormat(from date: Date) -> String {
        DateFormatterHelper.dateFormatter.dateFormat = "dd/MM/yyyy h:mm a"
        return string(from: date)
    }

    static func ddMMyyyyhmmaDateFormat(from string: String) -> Date? {
        DateFormatterHelper.dateFormatter.dateFormat = "dd/MM/yyyy h:mm a"
        return date(from: string)
    }

    // General
    static func string(from date: Date) -> String {
        return DateFormatterHelper.dateFormatter.string(from: date)
    }

    static func date(from string: String) -> Date? {
        return DateFormatterHelper.dateFormatter.date(from: string)
    }
}
