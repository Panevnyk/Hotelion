//
//  ServicesAssembly.swift
//  HotelionMain
//
//  Created by Vladyslav Panevnyk on 21.08.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import HotelionDomain
import HotelionIOSUI

final class ServicesAssembly {
    let viewModel: ServicesInteractorOutput
    let interactor: ServicesInteractorInput
    var view: ServicesView

    init(coordinatorDelegate: ServicesCoordinatorDelegate) {
        let viewModel = ServicesViewModel(coordinatorDelegate: coordinatorDelegate)
        let interactor = ServicesInteractor(output: viewModel)
        let view = ServicesView(viewModel: viewModel)

        viewModel.interactor = interactor

        self.viewModel = viewModel
        self.interactor = interactor
        self.view = view
    }
}
