//
//  ServicesViewModel.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 14.08.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import HotelionDomain

public protocol ServicesCoordinatorDelegate: class {
    func presentBookingScreen(viewModel: BookingViewModelProtocol)
    func presentHotelInfoScreen()
}

public final class ServicesViewModel: ObservableObject {
    // MARK: - Properties
    // Boundaries
    public var interactor: ServicesInteractorInput?
    private var coordinatorDelegate: ServicesCoordinatorDelegate?

    // Publishers
    @Published
    var serviceViewModels: [ServiceViewModel] = []
    @Published
    var error: Error? {
        didSet { isShowErrorAlert = error != nil }
    }
    @Published
    var isShowErrorAlert = false
    @Published
    var isShowingActivityIndicator: Bool = false

    // Static
    static let columnsCount = 2

    // MARK: - Inits
    public init(coordinatorDelegate: ServicesCoordinatorDelegate?) {
        self.coordinatorDelegate = coordinatorDelegate
    }
}

// MARK: - Public methods
extension ServicesViewModel {
    func loadServices() {
        isShowingActivityIndicator = true
        interactor?.loadServices()
    }

    func serviceDidTap(row: Int, column: Int) {
        let index = makeIndexFrom(row: row, column: column)
        let title: String
        switch index {
        case 1:
            title = "Setup cleaning time"
        case 2:
            title = "Setup washing time"
        case 3:
            title = "Setup SPA procedure time"
        case 4:
            title = "Setup taxi comming time"
        case 5:
            title = "Setup wake-up call time"
        default:
            title = "Invalid case value"
        }

        let bookingViewModel = makeBookingServiceViewModel(title: title)
        coordinatorDelegate?.presentBookingScreen(viewModel: bookingViewModel)
    }

    func hotelInfoDidTap() {
        coordinatorDelegate?.presentHotelInfoScreen()
    }
}

// MARK: - Helpers
extension ServicesViewModel {
    func makeIndexFrom(row: Int, column: Int) -> Int {
        (row * ServicesViewModel.columnsCount) + column
    }
}

// MARK: - ViewModels Factory
extension ServicesViewModel {
    func makeMultipleServicesViewModel() -> MultipleServicesViewModel {
        return MultipleServicesViewModel()
    }

    func makeBookingServiceViewModel(title: String) -> BookingViewModelProtocol {
        let calendarViewModel = makeCalendarViewModel()
        let bookingViewModel = BookingViewModel(
            title: title,
            calendarViewModel: calendarViewModel
        )
        return bookingViewModel
    }

    func makeCalendarViewModel() -> CalendarViewModel {
        let selectedEvent1 = SelectedEventViewModel(
            date: DateFactory.makeDate("26/09/2020"),
            hour: "10:30 AM"
        )
        let selectedEvent2 = SelectedEventViewModel(
            date: DateFactory.makeDate("27/09/2020"),
            hour: "12:00 PM"
        )
        let selectedEvent3 = SelectedEventViewModel(
            date: DateFactory.makeDate("28/09/2020"),
            hour: "11:25 AM"
        )
        let selectedEvent4 = SelectedEventViewModel(
            date: DateFactory.makeDate("01/10/2020"),
            hour: "9:00 AM"
        )

        let viewModel = CalendarViewModel(
            startDate: DateFactory.makeDate("25/09/2020"),
            endDate: DateFactory.makeDate("8/12/2020"),
            selectedEvents: [selectedEvent1,
                             selectedEvent2,
                             selectedEvent3,
                             selectedEvent4]
        )
        return viewModel
    }
}

// MARK: - ServicesInteractorOutput
extension ServicesViewModel: ServicesInteractorOutput {
    public func present(services: [Service]) {
        isShowingActivityIndicator = false
        serviceViewModels = services.map({
            var badgeTitle: String? = nil
            if let selectedDate = $0.selectedDate {
                badgeTitle = DateFormatterHelper.hmmaDateFormat(from: selectedDate)
            }
            return ServiceViewModel(
                id: $0.id,
                title: $0.title,
                img: $0.img,
                badgeTitle: badgeTitle)
        })
        self.error = nil
    }

    public func present(error: Error) {
        isShowingActivityIndicator = false
        serviceViewModels = []
        self.error = error
    }
}
