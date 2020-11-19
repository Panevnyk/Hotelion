//
//  AuthAssembly.swift
//  HotelionMain
//
//  Created by Vladyslav Panevnyk on 11.11.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import HotelionAuth
import HotelionCommon

final class LoginAssembly {
    let viewModel: LoginViewModelProtocol
    var viewController: LoginViewController

    init(serviceFactory: ServiceFactoryProtocol) {
        let viewModel = LoginViewModel(
            restApiManager: serviceFactory.makeRestApiManager()
        )
        let storyboard = UIStoryboard(name: "Auth", bundle: Bundle.auth)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        viewController.viewModel = viewModel

        self.viewModel = viewModel
        self.viewController = viewController
    }
}

final class RegistrationAssembly {
    let viewModel: RegisterViewModelProtocol
    var viewController: RegistrationViewController

    init(serviceFactory: ServiceFactoryProtocol) {
        let viewModel = RegisterViewModel(
            restApiManager: serviceFactory.makeRestApiManager()
        )
        let storyboard = UIStoryboard(name: "Auth", bundle: Bundle.auth)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        viewController.viewModel = viewModel

        self.viewModel = viewModel
        self.viewController = viewController
    }
}

final class ForgotPasswordAssembly {
    let viewModel: ForgotPasswordViewModelProtocol
    var viewController: ForgotPasswordViewController

    init(serviceFactory: ServiceFactoryProtocol) {
        let viewModel = ForgotPasswordViewModel(
            restApiManager: serviceFactory.makeRestApiManager()
        )
        let storyboard = UIStoryboard(name: "Auth", bundle: Bundle.auth)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        viewController.viewModel = viewModel

        self.viewModel = viewModel
        self.viewController = viewController
    }
}
