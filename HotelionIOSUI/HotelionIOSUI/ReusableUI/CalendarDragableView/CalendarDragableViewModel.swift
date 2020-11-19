//
//  CalendarViewModel.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 23.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

public final class CalendarDragableViewModel: ObservableObject {
    // MARK: - Properties
    @Published var title: String

    static let columnsCount = 7

    // MARK: - Init
    public init(title: String) {
        self.title = title
    }
}

extension CalendarDragableViewModel {
    static var hiddenState: CalendarDragableViewModel {
        CalendarDragableViewModel(title: "Empty")
    }
}
