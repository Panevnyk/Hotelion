//
//  Date+Extensions.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 27.01.2021.
//

import UIKit

extension Date {
    public init(timeIntervalSince1970MiliSec: TimeInterval) {
        self.init(timeIntervalSince1970: timeIntervalSince1970MiliSec / 1000)
    }

    public var timeIntervalSince1970MiliSec: TimeInterval {
        return timeIntervalSince1970 * 1000
    }
}
