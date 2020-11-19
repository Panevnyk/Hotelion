//
//  CalendarItemViewModelAdapter.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 24.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation

struct CalendarItemViewModelAdapter {
    func transform(startDate: Date,
                   endDate: Date,
                   dates: [Date],
                   selectedEvents: [SelectedEventViewModel]
    ) -> [CalendarItemViewModel] {
        var calendarItemViewModels: [CalendarItemViewModel] = []

        for index in 0 ..< dates.count {
            calendarItemViewModels.append(
                transform(startDate: startDate,
                          endDate: endDate,
                          date: dates[index],
                          index: index,
                          selectedEvents: selectedEvents)
            )
        }

        return calendarItemViewModels
    }

    func transform(startDate: Date,
                   endDate: Date,
                   date: Date,
                   index: Int,
                   selectedEvents: [SelectedEventViewModel]
    ) -> CalendarItemViewModel {
        let isAvailable = date >= startDate && date <= endDate
        let currentSelectedEvents = selectedEvents.filter { $0.date == date }
        return CalendarItemViewModel(date: date,
                                     isAvailable: isAvailable,
                                     index: index,
                                     selectedEvents: currentSelectedEvents)
    }
}
