//
//  CalendarViewModel.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 24.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation

public protocol CalendarViewModelOutput: class {
    func reloadData()
}

public protocol CalendarViewModelProtocol {
    var output: CalendarViewModelOutput? { get set }

    func itemsCount() -> Int
    func itemViewModel(for index: Int) -> CalendarItemViewModel
    func isAvailableItemViewModel(by index: Int) -> Bool
    func setEvent(by indexPath: IndexPath, date: Date)
    func hour(for indexPath: IndexPath) -> Date
    func getLocale() -> Locale
}

public final class CalendarViewModel: CalendarViewModelProtocol {
    // MARK: - Properties
    private let startDate: Date
    private let endDate: Date
    private var selectedEvents: [SelectedEventViewModel]
    private let calendarItemViewModels: [CalendarItemViewModel]
    private let displayCalendarItemViewModels: [CalendarItemViewModel]

    public weak var output: CalendarViewModelOutput?

    // MARK: - Inits
    public init(startDate: Date,
                endDate: Date,
                selectedEvents: [SelectedEventViewModel]) {
        self.startDate = startDate.startOfDay
        self.endDate = endDate.startOfDay
        self.selectedEvents = selectedEvents

        self.calendarItemViewModels =
            CalendarItemsRangeBuilder().makeCalendarItemsRange(
                startDate: self.startDate,
                endDate: self.endDate,
                selectedEvents: self.selectedEvents
            )
        self.displayCalendarItemViewModels =
            DisplayCalendarItemsRangeBuilder().makeDisplayCalendarItemsRange(
                startDate: self.startDate,
                endDate: self.endDate,
                itemViewModels: self.calendarItemViewModels
            )
    }

    // MARK: - Methods
    public func itemsCount() -> Int {
        return displayCalendarItemViewModels.count
    }

    public func itemViewModel(for index: Int) -> CalendarItemViewModel {
        return displayCalendarItemViewModels[index]
    }

    public func isAvailableItemViewModel(by index: Int) -> Bool {
        return itemViewModel(for: index).isAvailable
    }

    public func setEvent(by indexPath: IndexPath, date: Date) {
        let hour = DateFormatterHelper.hmmaDateFormat(from: date)
        let viewModel = itemViewModel(for: indexPath.item)
        let event = SelectedEventViewModel(date: viewModel.date,
                                           hour: hour)
        viewModel.selectedEvents = [event]

        self.output?.reloadData()
    }

    public func hour(for indexPath: IndexPath) -> Date {
        let viewModel = itemViewModel(for: indexPath.item)

        if let selectedEvent = viewModel.selectedEvents.first {
            let selectedDateString = DateFormatterHelper.ddMMyyyyDateFormat(from: selectedEvent.date)
            let selectedDateWithHourString = selectedDateString + " " + selectedEvent.hour

            if let selectedDateWithHour =
                DateFormatterHelper.ddMMyyyyhmmaDateFormat(from: selectedDateWithHourString) {
                return selectedDateWithHour
            }
        }

        return Date()
    }

    public func getLocale() -> Locale {
        return DateFormatterHelper.locale
    }
}
