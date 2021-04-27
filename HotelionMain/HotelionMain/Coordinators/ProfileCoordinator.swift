//
//  ProfileCoordinator.swift
//  HotelionMain
//
//  Created by Vladyslav Panevnyk on 05.02.2021.
//  Copyright © 2021 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import HotelionProfile
import HotelionCommon

protocol ProfileDelegate: class {}


final class ProfileCoordinator {
    // MARK: - Properties
    private let serviceFactory: ServiceFactoryProtocol
    private let navigationController: UINavigationController

    weak var delegate: ProfileDelegate?

    private weak var profileViewController: ProfileViewController?

    // MARK: - Inits
    init(navigationController: UINavigationController,
         serviceFactory: ServiceFactoryProtocol) {
        self.navigationController = navigationController
        self.serviceFactory = serviceFactory
    }

    // MARK: - Starts
    func start(animated: Bool) {
        startProfile(animated: animated)
    }

    private func startProfile(animated: Bool) {
        let profileAssembly = ProfileAssembly(serviceFactory: serviceFactory)
//        ordersAssembly.viewController.coordinatorDelegate = self
        profileAssembly.viewController.setupTabBar()
        self.profileViewController = profileAssembly.viewController

        navigationController.setViewControllers([profileAssembly.viewController], animated: animated)
    }
}
