//
//  BookingAssembly.swift
//  HotelionMain
//
//  Created by Vladyslav Panevnyk on 29.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import HotelionDomain
import HotelionIOSUI

final class BookingAssembly {
    var viewModel: BookingViewModelProtocol
    var view: BookingViewModelOutput & UIViewController

    init(viewModel: BookingViewModelProtocol) {
        self.viewModel = viewModel

        let view = BookingViewController.instantiate
        view.viewModel = self.viewModel
        self.viewModel.output = view

        self.view = view
    }
}
