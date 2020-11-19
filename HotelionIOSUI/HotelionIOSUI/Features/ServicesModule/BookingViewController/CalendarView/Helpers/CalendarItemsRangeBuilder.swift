//
//  CalendarItemsRangeBuilder.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 24.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation

final class CalendarItemsRangeBuilder {
    func makeCalendarItemsRange(startDate: Date,
                                endDate: Date,
                                selectedEvents: [SelectedEventViewModel]
    ) -> [CalendarItemViewModel] {
        var dates: [Date] = []
        dates.append(contentsOf: makeDateRangeFromMonday(to: startDate))
        dates.append(contentsOf: makeDateRange(from: startDate, to: endDate))
        dates.append(contentsOf: makeDateRangeToSunday(from: endDate))

        let adapter = CalendarItemViewModelAdapter()
        return adapter.transform(
            startDate: startDate,
            endDate: endDate,
            dates: dates,
            selectedEvents: selectedEvents)
    }

    private func makeDateRangeFromMonday(to date: Date) -> [Date] {
        func addYesterdayDatesBeforeFirstDayMonday(to date: Date, comp: [Date] = []) -> [Date] {
            var dates = comp
            dates.insert(date, at: 0)

            return date.isMonday
                ? dates
                : addYesterdayDatesBeforeFirstDayMonday(to: date.dayBefore, comp: dates)
        }

        return date.isMonday
            ? []
            : addYesterdayDatesBeforeFirstDayMonday(to: date.dayBefore)
    }

    private func makeDateRange(from startDate: Date, to endDate: Date, comp: [Date] = []) -> [Date] {
        var dates = comp
        dates.append(startDate)

        return startDate == endDate
            ? dates
            : makeDateRange(from: startDate.dayAfter, to: endDate, comp: dates)
    }

    private func makeDateRangeToSunday(from date: Date) -> [Date] {
        func addTomorrowDatesBeforeLastDaySunday(to date: Date, comp: [Date] = []) -> [Date] {
            var dates = comp
            dates.append(date)

            return date.isSunday
                ? dates
                : addTomorrowDatesBeforeLastDaySunday(to: date.dayAfter, comp: dates)
        }

        return date.isSunday
            ? []
            : addTomorrowDatesBeforeLastDaySunday(to: date.dayAfter)
    }
}
