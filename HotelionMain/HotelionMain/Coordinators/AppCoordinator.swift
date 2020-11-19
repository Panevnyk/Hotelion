//
//  AppCoordinator.swift
//  HotelionMain
//
//  Created by Vladyslav Panevnyk on 20.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import SwiftUI
import HotelionIOSUI

final class AppCoordinator {
    // MARK: - Properties
    private let window: UIWindow
    private let serviceFactory: ServiceFactoryProtocol
    private let navigationController: UINavigationController

    // Coordinators
    private var authCoordinator: AuthCoordinator?
    private var servicesListCoordinator: ServicesListCoordinator?

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
        successLogin()
    }

    func startAuthCoordinator() {
        let authCoordinator = AuthCoordinator(
            navigationController: navigationController,
            serviceFactory: serviceFactory
        )
        authCoordinator.start()
        authCoordinator.delegate = self

        self.authCoordinator = authCoordinator
        self.servicesListCoordinator = nil
    }
}

// MARK: - AuthCoordinatorDelegate
extension AppCoordinator: AuthCoordinatorDelegate {
    func successLogin() {
        let servicesListCoordinator = ServicesListCoordinator(
            navigationController: navigationController,
            serviceFactory: serviceFactory)
        servicesListCoordinator.start()

        self.servicesListCoordinator = servicesListCoordinator
        self.authCoordinator = nil
//        let servicesCoordinator = ServicesCoordinator(
//            navigationController: navigationController,
//            serviceFactory: serviceFactory)
//        servicesCoordinator.start()
//
//        self.servicesCoordinator = servicesCoordinator
//        self.authCoordinator = nil
    }

    func logOut() {}
}

// MARK: - QuestionnaireForSettlingCoordinatorDelegate
extension AppCoordinator: QuestionnaireForSettlingCoordinatorDelegate {
    func questionnaireSendedSuccessfully() {
//        servicesCoordinator = ServicesCoordinator(
//            navigationController: navigationController,
//            serviceFactory: serviceFactory)
//        servicesCoordinator?.start()
    }
}
