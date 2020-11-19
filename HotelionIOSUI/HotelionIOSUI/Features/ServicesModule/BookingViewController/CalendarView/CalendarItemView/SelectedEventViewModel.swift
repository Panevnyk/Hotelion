//
//  SelectedEventsViewModel.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 25.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation

public final class SelectedEventViewModel {
    // MARK: - Properties
    let date: Date
    let hour: String

    // MARK: - Inits
    public init(date: Date, hour: String) {
        self.date = date
        self.hour = hour
    }
}
