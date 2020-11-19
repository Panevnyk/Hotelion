//
//  ServicesListCoordinator.swift
//  HotelionMain
//
//  Created by Vladyslav Panevnyk on 13.11.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import HotelionServices
import HotelionAuth

protocol ServicesListDelegate: class {}


final class ServicesListCoordinator {
    // MARK: - Properties
    private let serviceFactory: ServiceFactoryProtocol
    private let navigationController: UINavigationController

    weak var delegate: ServicesListDelegate?

    private weak var servicesListViewController: UIViewController?
    private weak var serviceItemsListViewController: UIViewController?
    private weak var serviceItemViewController: UIViewController?

    // MARK: - Inits
    init(navigationController: UINavigationController, serviceFactory: ServiceFactoryProtocol) {
        self.navigationController = navigationController
        self.serviceFactory = serviceFactory
    }

    // MARK: - Starts
    func start() {
        startServicesList()
    }

    private func startServicesList() {
        let servicesListAssembly = ServicesListAssembly(serviceFactory: serviceFactory)
        servicesListAssembly.viewController.coordinatorDelegate = self
        self.servicesListViewController = servicesListAssembly.viewController

        navigationController.setViewControllers([servicesListAssembly.viewController], animated: true)
    }
}

// MARK: - ServicesListCoordinatorDelegate
extension ServicesListCoordinator: ServicesListCoordinatorDelegate {
    public func didSelectServiceGroup(_ serviceGroup: ServicesGroup) {
        let serviceItemsListAssembly = ServiceItemsListAssembly(
            serviceFactory: serviceFactory,
            serviceGroup: serviceGroup
        )
        serviceItemsListAssembly.viewController.coordinatorDelegate = self
        self.serviceItemsListViewController = serviceItemsListAssembly.viewController

        navigationController.pushViewController(serviceItemsListAssembly.viewController, animated: true)
    }
}

// MARK: - ServiceItemsListCoordinatorDelegate
extension ServicesListCoordinator: ServiceItemsListCoordinatorDelegate, ServiceItemCoordinatorDelegate {
    public func didSelectBackAction() {
        navigationController.popViewController(animated: true)
    }

    func didSelectService(_ service: Service) {
        let serviceItemAssembly = ServiceItemAssembly(
            serviceFactory: serviceFactory,
            service: service
        )
        serviceItemAssembly.viewController.coordinatorDelegate = self
        self.serviceItemViewController = serviceItemAssembly.viewController

        navigationController.pushViewController(serviceItemAssembly.viewController, animated: true)
    }
}
