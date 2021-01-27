//
//  FastCheckInAssembly.swift
//  HotelionMain
//
//  Created by Vladyslav Panevnyk on 13.01.2021.
//  Copyright © 2021 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import HotelionFastCheckIn
import HotelionCommon

final class CheckInMainAssembly {
    var viewController: CheckInMainViewController
    var viewModel: CheckInMainViewModelProtocol

    init(serviceFactory: ServiceFactoryProtocol) {
        let viewModel = CheckInMainViewModel(
            bookingRequestsLoader: serviceFactory.makeBookingRequestsLoader(),
            bookingsLoader: serviceFactory.makeBookingsLoader()
        )
        let storyboard = UIStoryboard(name: "FastCheckIn", bundle: Bundle.fastCheckIn)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CheckInMainViewController") as! CheckInMainViewController
        viewController.viewModel = viewModel
        viewModel.delegate = viewController

        self.viewController = viewController
        self.viewModel = viewModel
    }
}

final class FastCheckInAssembly {
    let viewModel: FastCheckInViewModelProtocol
    var viewController: FastCheckInViewController

    init(serviceFactory: ServiceFactoryProtocol) {
        let viewModel = FastCheckInViewModel(
            restApiManager: serviceFactory.makeRestApiManager(),
            bookingRequestsLoader: serviceFactory.makeBookingRequestsLoader()
        )
        let storyboard = UIStoryboard(name: "FastCheckIn", bundle: Bundle.fastCheckIn)
        let viewController = storyboard.instantiateViewController(withIdentifier: "FastCheckInViewController") as! FastCheckInViewController
        viewController.viewModel = viewModel
        viewModel.delegate = viewController

        self.viewModel = viewModel
        self.viewController = viewController
    }
}

final class AddPersonalInfoAssembly {
    let viewModel: AddPersonalInfoViewModelProtocol
    var viewController: AddPersonalInfoViewController

    init(serviceFactory: ServiceFactoryProtocol) {
        let viewModel = AddPersonalInfoViewModel(
            restApiManager: serviceFactory.makeRestApiManager()
        )
        let storyboard = UIStoryboard(name: "FastCheckIn", bundle: Bundle.fastCheckIn)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AddPersonalInfoViewController") as! AddPersonalInfoViewController
        viewController.viewModel = viewModel
        viewModel.delegate = viewController

        self.viewModel = viewModel
        self.viewController = viewController
    }
}

final class ScannerAssembly {
    var viewController: ScannerViewController

    init() {
        let storyboard = UIStoryboard(name: "FastCheckIn", bundle: Bundle.fastCheckIn)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ScannerViewController") as! ScannerViewController
        self.viewController = viewController
    }
}

final class DigitalSignatureAssembly {
    var viewController: DigitalSignatureViewController
    let viewModel: DigitalSignatureViewModelProtocol

    init(serviceFactory: ServiceFactoryProtocol) {
        let viewModel = DigitalSignatureViewModel()
        let storyboard = UIStoryboard(name: "FastCheckIn", bundle: Bundle.fastCheckIn)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DigitalSignatureViewController") as! DigitalSignatureViewController
        viewController.viewModel = viewModel

        self.viewController = viewController
        self.viewModel = viewModel
    }
}
