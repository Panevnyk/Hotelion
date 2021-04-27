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
    private var profileNavigationController = UINavigationController()

    private var servicesCoordinator: ServicesCoordinator?
    private var fastCheckInCoordinator: FastCheckInCoordinator?
    private var ordersCoordinator: OrdersCoordinator?
    private var profileCoordinator: ProfileCoordinator?

    // MARK: - Inits
    init(navigationController: UINavigationController, serviceFactory: ServiceFactoryProtocol) {
        self.navigationController = navigationController
        self.serviceFactory = serviceFactory
        self.tabBarController = UITabBarController()

        homeNavigationController.navigationBar.isHidden = true
        ordersNavigationController.navigationBar.isHidden = true
        profileNavigationController.navigationBar.isHidden = true
    }

    // MARK: - Starts
    func start(currentBooking: Booking,
               animationStyle: StartWithBookingAnimationStyle = .afterLogin) {
        let isStartAfterLogin = animationStyle == .afterLogin
        let isCoordinatorStartAnimated = !isStartAfterLogin
        let isTabBarStartAnimated = isStartAfterLogin
        let isNavigationStartAnimated = isStartAfterLogin

        makeServiceTab(currentBooking: currentBooking)
        makeOrdersTab(currentBooking: currentBooking)
        makeProfileTab()

        servicesCoordinator?.start(
            animated: isCoordinatorStartAnimated,
            currentBooking: currentBooking)
        ordersCoordinator?.start(
            animated: isCoordinatorStartAnimated,
            currentBooking: currentBooking)
        profileCoordinator?.start(animated: isCoordinatorStartAnimated)

        tabBarController.setViewControllers(
            [homeNavigationController, ordersNavigationController, profileNavigationController],
            animated: isTabBarStartAnimated)
        tabBarController.selectedIndex = 0

        navigationController.setViewControllers(
            [tabBarController],
            animated: isNavigationStartAnimated)

        fastCheckInCoordinator = nil
    }

    func start() {
        makeFastCheckTab()
        makeProfileTab()

        fastCheckInCoordinator?.start(animated: false)
        fastCheckInCoordinator?.delegate = self

        profileCoordinator?.start(animated: false)

        tabBarController.setViewControllers(
            [homeNavigationController, profileNavigationController],
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

    func makeProfileTab() {
        let profileCoordinator = ProfileCoordinator(
            navigationController: profileNavigationController,
            serviceFactory: serviceFactory)

        self.profileCoordinator = profileCoordinator
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
