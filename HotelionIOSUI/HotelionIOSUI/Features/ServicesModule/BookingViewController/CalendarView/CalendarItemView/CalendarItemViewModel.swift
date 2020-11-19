//
//  CalendarItemViewModel.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 24.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation

public final class CalendarItemViewModel {
    // MARK: - Properties
    let date: Date
    let isAvailable: Bool
    private(set) var index: Int
    var selectedEvents: [SelectedEventViewModel]

    // MARK: - Inits
    public init(date: Date,
                isAvailable: Bool,
                index: Int,
                selectedEvents: [SelectedEventViewModel]) {
        self.date = date
        self.isAvailable = isAvailable
        self.index = index
        self.selectedEvents = selectedEvents
    }

    var displayDay: String { String(date.day) }
    var displayMonth: String? {
        index == 0 || date.isFirstDayOfMonth ? DateFormatterHelper.mmmDateFormat(from: date) : nil
    }
    var displayHour: String? {
        if selectedEvents.count == 0 {
            return nil
        } else if selectedEvents.count == 1 {
            return selectedEvents[0].hour
        } else {
            return "\(selectedEvents.count)\nevents"
        }
    }

    func updateIndex(to index: Int) {
        self.index = index
    }
}

// MARK: - IsEmpty
extension CalendarItemViewModel {
    static func makeIsEmpty(index: Int) -> CalendarItemViewModel {
        return CalendarItemViewModel(
            date: Date(timeIntervalSince1970: 0),
            isAvailable: false,
            index: index,
            selectedEvents: [])
    }

    var isEmpty: Bool { date.timeIntervalSince1970 == 0 }
}
