//
//  OrdersAssembly.swift
//  HotelionMain
//
//  Created by Vladyslav Panevnyk on 25.11.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import HotelionOrders
import HotelionCommon

final class OrdersAssembly {
    let viewModel: OrdersViewModelProtocol
    var viewController: OrdersViewController

    init(serviceFactory: ServiceFactoryProtocol, currentBooking: Booking) {
        let viewModel = OrdersViewModel(
            restApiManager: serviceFactory.makeRestApiManager(),
            servicesLoader: serviceFactory.makeServicesLoader(
                hotelId: currentBooking.hotelId),
            ordersLoader: serviceFactory.makeOrdersLoader(),
            currentBooking: currentBooking
        )
        let storyboard = UIStoryboard(name: "Orders", bundle: Bundle.orders)
        let viewController = storyboard.instantiateViewController(withIdentifier: "OrdersViewController") as! OrdersViewController
        viewController.viewModel = viewModel
        viewModel.delegate = viewController

        self.viewModel = viewModel
        self.viewController = viewController
    }
}

