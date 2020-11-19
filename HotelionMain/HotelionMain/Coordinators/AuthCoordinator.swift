//
//  AuthCoordinator.swift
//  HotelionMain
//
//  Created by Vladyslav Panevnyk on 11.11.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import HotelionAuth

protocol LogOutCoordinatorDelegate: class {
    func logOut()
}

protocol AuthCoordinatorDelegate: LogOutCoordinatorDelegate {
    func successLogin()
}

final class AuthCoordinator {
    // MARK: - Properties
    private let serviceFactory: ServiceFactoryProtocol
    private let navigationController: UINavigationController

    weak var delegate: AuthCoordinatorDelegate?

    private weak var loginViewController: UIViewController?
    private weak var registrationViewController: UIViewController?
    private weak var forgotPasswordViewController: UIViewController?

    // MARK: - Inits
    init(navigationController: UINavigationController, serviceFactory: ServiceFactoryProtocol) {
        self.navigationController = navigationController
        self.serviceFactory = serviceFactory
    }

    // MARK: - Starts
    func start() {
        didSelectLogin(animated: false)
    }
}

// MARK: - BaseAuthCoordinatorDelegate
extension AuthCoordinator: BaseAuthCoordinatorDelegate {
    func didSelectLogin() {
        didSelectLogin(animated: true)
    }
    
    func didSelectLogin(animated: Bool) {
        let loginAssembly = LoginAssembly(serviceFactory: serviceFactory)
        loginAssembly.viewController.coordinatorDelegate = self
        self.loginViewController = loginAssembly.viewController

        navigationController.setViewControllers([loginAssembly.viewController], animated: animated)
    }

    func didSelectSignUp() {
        let registrationAssembly = RegistrationAssembly(serviceFactory: serviceFactory)
        registrationAssembly.viewController.coordinatorDelegate = self
        self.registrationViewController = registrationAssembly.viewController

        navigationController.setViewControllers([registrationAssembly.viewController], animated: true)
    }

    func didSelectPrivacyPolicy() {}

    func successLogin() {
        delegate?.successLogin()
    }
}

// MARK: - LoginViewControllerCoordinatorDelegate
extension AuthCoordinator: LoginViewControllerCoordinatorDelegate {
    func didSelectForgotPassword() {
        let forgotPasswordAssembly = ForgotPasswordAssembly(serviceFactory: serviceFactory)
        forgotPasswordAssembly.viewController.coordinatorDelegate = self
        self.forgotPasswordViewController = forgotPasswordAssembly.viewController

        navigationController.pushViewController(forgotPasswordAssembly.viewController, animated: true)
    }

    func successLoginWithoutCode(email: String, password: String) {

    }
}

// MARK: - RegistrationViewControllerCoordinatorDelegate
extension AuthCoordinator: RegistrationViewControllerCoordinatorDelegate {
    func successRegistration() {
        delegate?.successLogin()
    }
}

// MARK: - ForgotPasswordCoordinatorDelegate
extension AuthCoordinator: ForgotPasswordCoordinatorDelegate {
    func didSelectLoginWith(email: String) {
//        let loginViewController = LoginViewController.instantiate
//        loginViewController.loginViewControllerCoordinator = self
//        self.loginViewController = loginViewController
//
//        loginViewController.config(loginViewModel: LoginViewModel(defaultEmail: email))
//
//        navigationController?.setViewControllers([loginViewController], animated: true)
    }

    func dissmiss() {
        navigationController.popViewController(animated: true)
    }
}
