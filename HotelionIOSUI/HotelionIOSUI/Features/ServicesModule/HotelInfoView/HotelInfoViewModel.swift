//
//  HotelInfoViewModel.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 02.10.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI

public protocol HotelInfoCoordinatorDelegate: class {
    func dismiss()
}

public final class HotelInfoViewModel: ObservableObject {
    // MARK: - Properties
    private var coordinatorDelegate: HotelInfoCoordinatorDelegate?

    // MARK: - Inits
    public init(coordinatorDelegate: HotelInfoCoordinatorDelegate?) {
        self.coordinatorDelegate = coordinatorDelegate
    }

    // MARK: - Methods
    func dismissDidTap() {
        coordinatorDelegate?.dismiss()
    }
}
