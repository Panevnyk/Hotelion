//
//  DateFormatterHelper.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 27.01.2021.
//

import UIKit

public final class DateHelper {
    // MARK: - Properties
    // Shared
    public static let shared = DateHelper()

    // Calendar
    public var utcCalendar = Calendar.current

    // UTC TimeZone
    public var utcTimeZone = TimeZone(secondsFromGMT: 0)!

    // Formatters
    private var dateFormatter = DateFormatter()

    public var dateStyleFormatter: DateFormatter {
        let dateFormatter = self.dateFormatter
        dateFormatter.dateFormat = "MMM dd, yyyy"
        dateFormatter.timeZone = utcTimeZone
        return dateFormatter
    }

    // MARK: - Init
    init() {
        utcCalendar.timeZone = utcTimeZone
    }
}
