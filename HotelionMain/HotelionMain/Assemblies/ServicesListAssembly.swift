//
//  ServicesListAssembly.swift
//  HotelionMain
//
//  Created by Vladyslav Panevnyk on 13.11.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import HotelionServices
import HotelionCommon

final class ServicesListAssembly {
    let viewModel: ServicesListViewModelProtocol
    var viewController: ServicesListViewController

    init(serviceFactory: ServiceFactoryProtocol) {
        let viewModel = ServicesListViewModel(
            restApiManager: serviceFactory.makeRestApiManager()
        )
        let storyboard = UIStoryboard(name: "Services", bundle: Bundle.services)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ServicesListViewController") as! ServicesListViewController
        viewController.viewModel = viewModel

        self.viewModel = viewModel
        self.viewController = viewController
    }
}

final class ServiceItemsListAssembly {
    let viewModel: ServiceItemsListViewModelProtocol
    var viewController: ServiceItemsListViewController

    init(serviceFactory: ServiceFactoryProtocol, serviceGroup: ServicesGroup) {
        let viewModel = ServiceItemsListViewModel(
            restApiManager: serviceFactory.makeRestApiManager(),
            serviceGroup: serviceGroup
        )
        let storyboard = UIStoryboard(name: "Services", bundle: Bundle.services)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ServiceItemsListViewController") as! ServiceItemsListViewController
        viewController.viewModel = viewModel

        self.viewModel = viewModel
        self.viewController = viewController
    }
}

final class ServiceItemAssembly {
    let viewModel: ServiceItemViewModelProtocol
    var viewController: ServiceItemViewController

    init(serviceFactory: ServiceFactoryProtocol, service: Service) {
        let viewModel = ServiceItemViewModel(
            service: service,
            restApiManager: serviceFactory.makeRestApiManager()
        )
        let storyboard = UIStoryboard(name: "Services", bundle: Bundle.services)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ServiceItemViewController") as! ServiceItemViewController
        viewController.viewModel = viewModel

        self.viewModel = viewModel
        self.viewController = viewController
    }
}
