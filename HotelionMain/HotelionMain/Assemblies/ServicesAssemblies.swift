//
//  ServicesAssembly.swift
//  HotelionMain
//
//  Created by Vladyslav Panevnyk on 13.11.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import HotelionServices
import HotelionCommon

final class ServicesAssembly {
    let viewModel: ServicesListViewModelProtocol
    var viewController: ServicesListViewController

    init(serviceFactory: ServiceFactoryProtocol,
         currentBooking: Booking) {
        let viewModel = ServicesListViewModel(
            restApiManager: serviceFactory.makeRestApiManager(),
            hotelLoader: serviceFactory.makeHotelLoader(hotelId: currentBooking.hotelId),
            serviceLoader: serviceFactory.makeServicesLoader(hotelId: currentBooking.hotelId),
            currentBooking: currentBooking
        )
        let storyboard = UIStoryboard(name: "Services", bundle: Bundle.services)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ServicesListViewController") as! ServicesListViewController
        viewController.viewModel = viewModel
        viewModel.delegate = viewController

        self.viewModel = viewModel
        self.viewController = viewController
    }
}

final class ServiceItemsAssembly {
    var viewModel: ServiceItemsListViewModelProtocol
    var viewController: ServiceItemsListViewController

    init(selectedItem: Int,
         serviceFactory: ServiceFactoryProtocol,
         viewModelFactory: ServiceItemsListViewModelFactory) {
        let viewModel = viewModelFactory.makeServiceItemsListViewModel(by: selectedItem)
        let storyboard = UIStoryboard(name: "Services", bundle: Bundle.services)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ServiceItemsListViewController") as! ServiceItemsListViewController

        self.viewModel = viewModel
        self.viewController = viewController

        self.viewController.viewModel = self.viewModel
        self.viewModel.delegate = self.viewController
    }
}

final class ServiceItemAssembly {
    let viewModel: ServiceItemViewModelProtocol
    var viewController: ServiceItemViewController

    init(serviceFactory: ServiceFactoryProtocol, service: Service, currentBooking: Booking) {
        let viewModel = ServiceItemViewModel(
            service: service,
            restApiManager: serviceFactory.makeRestApiManager(),
            bookingsLoader: serviceFactory.makeBookingsLoader(),
            currentBooking: currentBooking
        )
        let storyboard = UIStoryboard(name: "Services", bundle: Bundle.services)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ServiceItemViewController") as! ServiceItemViewController
        viewController.viewModel = viewModel

        self.viewModel = viewModel
        self.viewController = viewController
    }
}
