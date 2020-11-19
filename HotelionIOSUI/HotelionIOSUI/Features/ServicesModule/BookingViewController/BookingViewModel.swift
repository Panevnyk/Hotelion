//
//  BookingViewModel.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 29.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation

public protocol BookingViewModelProtocol {
    var output: BookingViewModelOutput? { get set }

    func getCalendarViewModel() -> CalendarViewModel
    func getTitle() -> String
}

public protocol BookingViewModelOutput: class {
    var viewModel: BookingViewModelProtocol! { get set }
}

public final class BookingViewModel: BookingViewModelProtocol {
    // MARK: - Properties
    private let title: String
    private let calendarViewModel: CalendarViewModel
    public weak var output: BookingViewModelOutput?

    // MARK: - Inits
    public init(title: String,
                calendarViewModel: CalendarViewModel) {
        self.title = title
        self.calendarViewModel = calendarViewModel
    }

    // MARK: - Public methods
    public func getCalendarViewModel() -> CalendarViewModel { calendarViewModel }
    public func getTitle() -> String { title }
}
