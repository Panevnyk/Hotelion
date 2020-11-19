//
//  HotelAssembly.swift
//  HotelionMain
//
//  Created by Vladyslav Panevnyk on 02.10.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import HotelionDomain
import HotelionIOSUI

final class HotelInfoAssembly {
    var viewModel: HotelInfoViewModel
    var view: HotelInfoView

    init(coordinatorDelegate: HotelInfoCoordinatorDelegate) {
        let viewModel = HotelInfoViewModel(coordinatorDelegate: coordinatorDelegate)
        let view = HotelInfoView(viewModel: viewModel)

        self.viewModel = viewModel
        self.view = view
    }
}
