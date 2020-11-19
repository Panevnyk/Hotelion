//
//  ServiceItemsListViewModel.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 17.11.2020.
//

import Foundation
import RestApiManager
import HotelionCommon

public protocol ServiceItemsListViewModelProtocol {
    func itemsCount(in section: Int) -> Int
    func servicesGroupViewModel(for item: Int) -> ServicesGroupItemViewModelProtocol
    func getServiceGroupName() -> String
    func getService(by item: Int) -> Service
}

public final class ServiceItemsListViewModel: ServiceItemsListViewModelProtocol {
    // MARK: - Properties
    // Boundaries
    private let restApiManager: RestApiManager
    private let serviceGroup: ServicesGroup

    // Models
    private var services: [Service] = []

    // MARK: - Inits
    public init(restApiManager: RestApiManager, serviceGroup: ServicesGroup) {
        self.restApiManager = restApiManager
        self.serviceGroup = serviceGroup
        loadServiceItemsList()
    }
}

// MARK: - Public methods
extension ServiceItemsListViewModel {
    public func itemsCount(in section: Int) -> Int {
        return services.count
    }

    public func servicesGroupViewModel(for item: Int) -> ServicesGroupItemViewModelProtocol {
        let service = getService(by: item)

        return ServicesGroupItemViewModel(
            name: service.name.uppercased(),
            img: service.img
        )
    }

    public func getServiceGroupName() -> String {
        return serviceGroup.name
    }

    public func getService(by item: Int) -> Service {
        return services[item]
    }
}

// MARK: - RestApiable
extension ServiceItemsListViewModel {
    public func loadServiceItemsList() {
        let descr = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum!!!"
        let serviceOptions = [
            ServiceOption(name: "First item", price: 10.5),
            ServiceOption(name: "Second item", price: 32.1),
            ServiceOption(name: "Third item", price: 6.0)
        ]

        services = [
            Service(id: "1", hotelId: "1", serviceGroupId: "1", name: "Burger", description: descr, img: "icWakeUpCall", serviceOptions: serviceOptions, serviceDeliveries: [.bringItNow, .arrangeTime]),
            Service(id: "2", hotelId: "2", serviceGroupId: "1", name: "Pizza", description: descr, img: "icTaxi", serviceOptions: serviceOptions, serviceDeliveries: [.bringItNow, .arrangeTime]),
            Service(id: "3", hotelId: "3", serviceGroupId: "1", name: "Spagetti", description: descr, img: "icTowelReplacement", serviceOptions: serviceOptions, serviceDeliveries: [.bringItNow, .arrangeTime]),
            Service(id: "4", hotelId: "4", serviceGroupId: "1", name: "Soup", description: descr, img: "icCleaning", serviceOptions: serviceOptions, serviceDeliveries: [.bringItNow, .arrangeTime]),
            Service(id: "5", hotelId: "5", serviceGroupId: "1", name: "Hotdog", description: descr, img: "icWashing", serviceOptions: serviceOptions, serviceDeliveries: [.bringItNow, .arrangeTime])
        ]

//        let parameters = ServiceGroupParameters(hotelId: "5faa610205968d002042402e")
//        let method = ServiceGroupRestApiMethods.getList(parameters)
//
//        ActivityIndicatorHelper.shared.show()
//        restApiManager.call(method: method) { [weak self] (result: Result<[ServicesGroup]>) in
//            DispatchQueue.main.async {
//                ActivityIndicatorHelper.shared.hide()
//
//                switch result {
//                case .success(let servicesGroups):
//                    self?.servicesGroups = servicesGroups
//                case .failure(let error):
//                    NotificationBannerHelper.showBanner(error)
//                }
//            }
//        }
    }
}
