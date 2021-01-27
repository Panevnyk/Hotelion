//
//  AppCoordinator.swift
//  HotelionMain
//
//  Created by Vladyslav Panevnyk on 20.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import SwiftUI
import HotelionCommon

final class AppCoordinator {
    // MARK: - Properties
    private let window: UIWindow
    private let serviceFactory: ServiceFactoryProtocol
    private let navigationController: UINavigationController

    // Coordinators
    private var authCoordinator: AuthCoordinator?
    private var mainTabBarCoordinator: MainTabBarCoordinator?

    // MARK: - Inits
    init?(window: UIWindow?, serviceFactory: ServiceFactoryProtocol = ServiceFactory()) {
        guard let window = window else { return nil }
        self.window = window
        self.serviceFactory = serviceFactory
        self.navigationController = UINavigationController()

        navigationController.navigationBar.isHidden = true
    }

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

//        startAuthCoordinator()
        startMainTabBarCoordinator()
    }

    func startAuthCoordinator() {
        let authCoordinator = AuthCoordinator(
            navigationController: navigationController,
            serviceFactory: serviceFactory
        )
        authCoordinator.start()
        authCoordinator.delegate = self

        self.authCoordinator = authCoordinator
        self.mainTabBarCoordinator = nil
    }

    func startMainTabBarCoordinator(currentBooking: Booking) {
        let mainTabBarCoordinator = MainTabBarCoordinator(
            navigationController: navigationController,
            serviceFactory: serviceFactory)
        mainTabBarCoordinator.start(currentBooking: currentBooking)

        self.mainTabBarCoordinator = mainTabBarCoordinator
        self.authCoordinator = nil
    }

    func startMainTabBarCoordinator() {
        let mainTabBarCoordinator = MainTabBarCoordinator(
            navigationController: navigationController,
            serviceFactory: serviceFactory)
        mainTabBarCoordinator.start()

        self.mainTabBarCoordinator = mainTabBarCoordinator
        self.authCoordinator = nil
    }
}

// MARK: - AuthCoordinatorDelegate
extension AppCoordinator: AuthCoordinatorDelegate {
    func successLogin() {
        serviceFactory.makeBookingsLoader().loadBookings { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case .success(let bookings):
                if let currentBooking = bookings.first {
                    self.startMainTabBarCoordinator(currentBooking: currentBooking)
                } else {
                    self.startMainTabBarCoordinator()
                }
            case .failure(let error):
                NotificationBannerHelper.showBanner(error)
            }
        }
    }

    func logOut() {}
}
