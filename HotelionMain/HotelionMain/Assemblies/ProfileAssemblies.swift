//
//  ProfileAssemblies.swift
//  HotelionMain
//
//  Created by Vladyslav Panevnyk on 05.02.2021.
//  Copyright © 2021 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import HotelionProfile
import HotelionCommon

final class ProfileAssembly {
    let viewModel: ProfileViewModelProtocol
    var viewController: ProfileViewController

    init(serviceFactory: ServiceFactoryProtocol) {
        let viewModel = ProfileViewModel()
        let storyboard = UIStoryboard(name: "Profile", bundle: Bundle.profile)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        viewController.viewModel = viewModel

        self.viewModel = viewModel
        self.viewController = viewController
    }
}
