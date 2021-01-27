//
//  ServicesCoordinator.swift
//  HotelionMain
//
//  Created by Vladyslav Panevnyk on 13.11.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import HotelionServices
import HotelionAuth
import HotelionCommon

protocol ServicesDelegate: class {}


final class ServicesCoordinator {
    // MARK: - Properties
    private let serviceFactory: ServiceFactoryProtocol
    private let navigationController: UINavigationController
    private let currentBooking: Booking

    weak var delegate: ServicesDelegate?

    private weak var servicesListViewController: UIViewController?
    private weak var serviceItemsListViewController: UIViewController?
    private weak var serviceItemViewController: UIViewController?

    // MARK: - Inits
    init(navigationController: UINavigationController,
         serviceFactory: ServiceFactoryProtocol,
         currentBooking: Booking) {
        self.navigationController = navigationController
        self.serviceFactory = serviceFactory
        self.currentBooking = currentBooking
    }

    // MARK: - Starts
    func start(animated: Bool,
               currentBooking: Booking) {
        startServices(animated: animated,
                      currentBooking: currentBooking)
    }

    func startServices(animated: Bool,
                               currentBooking: Booking) {
        let servicesAssembly = ServicesAssembly(
            serviceFactory: serviceFactory,
            currentBooking: currentBooking
        )
        servicesAssembly.viewController.coordinatorDelegate = self
        servicesAssembly.viewController.setupTabBar()
        self.servicesListViewController = servicesAssembly.viewController

        navigationController.setViewControllers([servicesAssembly.viewController], animated: animated)
    }
}

// MARK: - ServicesListCoordinatorDelegate
extension ServicesCoordinator: ServicesListCoordinatorDelegate {
    public func didSelectServiceGroup(in viewController: ServicesListViewController, by item: Int) {
        let serviceItemsAssembly = ServiceItemsAssembly(
            selectedItem: item,
            serviceFactory: serviceFactory,
            viewModelFactory: viewController.viewModel
        )
        serviceItemsAssembly.viewController.coordinatorDelegate = self
        self.serviceItemsListViewController = serviceItemsAssembly.viewController

        navigationController.pushViewController(serviceItemsAssembly.viewController, animated: true)
    }
}

// MARK: - ServiceItemsListCoordinatorDelegate
extension ServicesCoordinator: ServiceItemsListCoordinatorDelegate, ServiceItemCoordinatorDelegate {
    public func didSelectBackAction() {
        navigationController.popViewController(animated: true)
    }

    func didSelectService(_ service: Service) {
        let serviceItemAssembly = ServiceItemAssembly(
            serviceFactory: serviceFactory,
            service: service,
            currentBooking: currentBooking
        )
        serviceItemAssembly.viewController.coordinatorDelegate = self
        self.serviceItemViewController = serviceItemAssembly.viewController

        navigationController.pushViewController(serviceItemAssembly.viewController, animated: true)
    }
}
