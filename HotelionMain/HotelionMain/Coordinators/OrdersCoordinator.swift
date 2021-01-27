//
//  OrdersCoordinator.swift
//  HotelionMain
//
//  Created by Vladyslav Panevnyk on 25.11.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import HotelionServices
import HotelionAuth
import HotelionCommon

protocol OrdersDelegate: class {}


final class OrdersCoordinator {
    // MARK: - Properties
    private let serviceFactory: ServiceFactoryProtocol
    private let navigationController: UINavigationController

    weak var delegate: OrdersDelegate?

    private weak var ordersViewController: UIViewController?

    // MARK: - Inits
    init(navigationController: UINavigationController,
         serviceFactory: ServiceFactoryProtocol) {
        self.navigationController = navigationController
        self.serviceFactory = serviceFactory
    }

    // MARK: - Starts
    func start(animated: Bool,
               currentBooking: Booking) {
        startOrders(animated: animated,
                    currentBooking: currentBooking)
    }

    private func startOrders(animated: Bool,
                             currentBooking: Booking) {
        let ordersAssembly = OrdersAssembly(serviceFactory: serviceFactory,
                                            currentBooking: currentBooking)
//        ordersAssembly.viewController.coordinatorDelegate = self
        ordersAssembly.viewController.setupTabBar()
        self.ordersViewController = ordersAssembly.viewController

        navigationController.setViewControllers([ordersAssembly.viewController], animated: animated)
    }
}
