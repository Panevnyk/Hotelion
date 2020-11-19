//
//  ServicesCoordinator.swift
//  HotelionMain
//
//  Created by Vladyslav Panevnyk on 02.10.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import SwiftUI
import HotelionIOSUI

final class ServicesCoordinator {
    // MARK: - Properties
    private let serviceFactory: ServiceFactoryProtocol
    private let navigationController: UINavigationController

    private weak var servicesViewController: UIViewController?

    // MARK: - Inits
    init(navigationController: UINavigationController, serviceFactory: ServiceFactoryProtocol) {
        self.navigationController = navigationController
        self.serviceFactory = serviceFactory
    }

    // MARK: - Start
    func start() {
        let servicesAssembly = ServicesAssembly(coordinatorDelegate: self)
        let servicesViewController = UIHostingController(rootView: servicesAssembly.view)
        navigationController.setViewControllers([servicesViewController], animated: true)

        self.servicesViewController = servicesViewController
    }
}

// MARK: - ServicesCoordinatorDelegate
extension ServicesCoordinator: ServicesCoordinatorDelegate {
    func presentBookingScreen(viewModel: BookingViewModelProtocol) {
        let bookingAssembly = BookingAssembly(viewModel: viewModel)
        let bookingViewController = bookingAssembly.view
        servicesViewController?.present(bookingViewController, animated: true, completion: nil)
    }

    func presentHotelInfoScreen() {
        let hotelInfoAssembly = HotelInfoAssembly(coordinatorDelegate: self)
        let hotelInfoViewController = UIHostingController(rootView: hotelInfoAssembly.view)
        navigationController.pushViewController(hotelInfoViewController, animated: true)
    }
}

// MARK: - HotelInfoCoordinatorDelegate
extension ServicesCoordinator: HotelInfoCoordinatorDelegate {
    func dismiss() {
        navigationController.popViewController(animated: true)
    }
}
