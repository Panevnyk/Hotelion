//
//  MainTabBarCoordinator.swift
//  HotelionMain
//
//  Created by Vladyslav Panevnyk on 25.11.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import HotelionCommon
import RestApiManager

protocol MainTabBarDelegate: class {}

final class MainTabBarCoordinator {
    // MARK: - Properties
    private let serviceFactory: ServiceFactoryProtocol
    private let navigationController: UINavigationController
    private let tabBarController: UITabBarController

    weak var delegate: MainTabBarDelegate?

    private var homeNavigationController = UINavigationController()
    private var ordersNavigationController = UINavigationController()

    private var servicesCoordinator: ServicesCoordinator?
    private var fastCheckInCoordinator: FastCheckInCoordinator?
    private var ordersCoordinator: OrdersCoordinator?

    // MARK: - Inits
    init(navigationController: UINavigationController, serviceFactory: ServiceFactoryProtocol) {
        self.navigationController = navigationController
        self.serviceFactory = serviceFactory
        self.tabBarController = UITabBarController()

        homeNavigationController.navigationBar.isHidden = true
        ordersNavigationController.navigationBar.isHidden = true
    }

    // MARK: - Starts
    func start(currentBooking: Booking,
               animationStyle: StartWithBookingAnimationStyle = .afterLogin) {
        let isStartAfterLogin = animationStyle == .afterLogin
        let isServicesCoordinatorStartAnimated = !isStartAfterLogin
        let isOrdersCoordinatorStartAnimated = !isStartAfterLogin
        let isTabBarStartAnimated = isStartAfterLogin
        let isNavigationStartAnimated = isStartAfterLogin

        makeServiceTab(currentBooking: currentBooking)
        makeOrdersTab(currentBooking: currentBooking)

        servicesCoordinator?.start(
            animated: isServicesCoordinatorStartAnimated,
            currentBooking: currentBooking)
        ordersCoordinator?.start(
            animated: isOrdersCoordinatorStartAnimated,
            currentBooking: currentBooking)

        tabBarController.setViewControllers(
            [homeNavigationController, ordersNavigationController],
            animated: isTabBarStartAnimated)
        tabBarController.selectedIndex = 0

        navigationController.setViewControllers(
            [tabBarController],
            animated: isNavigationStartAnimated)

        fastCheckInCoordinator = nil
    }

    func start() {
        makeFastCheckTab()

        fastCheckInCoordinator?.start(animated: false)
        fastCheckInCoordinator?.delegate = self

        tabBarController.setViewControllers(
            [homeNavigationController],
            animated: true)
        tabBarController.selectedIndex = 0
        navigationController.setViewControllers([tabBarController], animated: true)

        servicesCoordinator = nil
    }
}

// MARK: - Make tabs
private extension MainTabBarCoordinator {
    func makeServiceTab(currentBooking: Booking) {
        let servicesCoordinator = ServicesCoordinator(
            navigationController: homeNavigationController,
            serviceFactory: serviceFactory,
            currentBooking: currentBooking)

        self.servicesCoordinator = servicesCoordinator
    }

    func makeFastCheckTab() {
        let fastCheckInCoordinator = FastCheckInCoordinator(
            navigationController: homeNavigationController,
            serviceFactory: serviceFactory)

        self.fastCheckInCoordinator = fastCheckInCoordinator
    }

    func makeOrdersTab(currentBooking: Booking) {
        let ordersCoordinator = OrdersCoordinator(
            navigationController: ordersNavigationController,
            serviceFactory: serviceFactory)

        self.ordersCoordinator = ordersCoordinator
    }
}

// MARK: - FastCheckInDelegate
extension MainTabBarCoordinator: FastCheckInDelegate {
    func didLoadBoking(currentBooking: Booking) {
        start(currentBooking: currentBooking,
              animationStyle: .afterFastCheckIn)
    }
}

// MARK: - StartWithBookingAnimationStyle
extension MainTabBarCoordinator {
    enum StartWithBookingAnimationStyle {
        case afterLogin
        case afterFastCheckIn
    }
}
