//
//  DateFactory.swift
//  HabbityIOSUITests
//
//  Created by Vladyslav Panevnyk on 20.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation

private let dateFormatter: DateFormatter = {
   let dateFormatter = DateFormatter()
   dateFormatter.dateFormat = "MM/dd/yyyy"
   dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)!
   return dateFormatter
}()

func makeDate(_ stringDate: String) -> Date {
    return dateFormatter.date(from: stringDate)!
}
