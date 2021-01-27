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
    var delegate: ServiceItemsViewModelDelegate? { get set }

    func itemsCount(in section: Int) -> Int
    func servicesGroupViewModel(for item: Int) -> ServicesGroupItemViewModelProtocol
    func getServiceGroupName() -> String
    func getService(by item: Int) -> Service
}

public protocol ServiceItemsViewModelDelegate: class {
    func reloadData()
}

public final class ServiceItemsListViewModel: ServiceItemsListViewModelProtocol {
    // MARK: - Properties
    // Boundaries
    private let serviceGroup: ServicesGroup
    private let services: [Service]

    // Delegate
    public weak var delegate: ServiceItemsViewModelDelegate?

    // MARK: - Inits
    public init(serviceGroup: ServicesGroup,
                services: [Service]) {
        self.serviceGroup = serviceGroup
        self.services = services
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
            name: service.name,
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
//        let descr = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum!!!"
//        let serviceOptions = [
//            ServiceOption(id: "1", name: "First item", price: 10.5),
//            ServiceOption(id: "2", name: "Second item", price: 32.1),
//            ServiceOption(id: "3", name: "Third item", price: 6.0)
//        ]
//
//        services = [
//            Service(id: "1", hotelId: "1", serviceGroupId: "1", name: "Hot stone massage", description: descr, img: "img1", serviceOptions: serviceOptions, serviceDeliveries: [.bringItNow, .arrangeTime]),
//            Service(id: "2", hotelId: "2", serviceGroupId: "1", name: "Mannicure", description: descr, img: "img2", serviceOptions: serviceOptions, serviceDeliveries: [.bringItNow, .arrangeTime]),
//            Service(id: "3", hotelId: "3", serviceGroupId: "1", name: "SPA center", description: descr, img: "img3", serviceOptions: serviceOptions, serviceDeliveries: [.bringItNow, .arrangeTime]),
//            Service(id: "4", hotelId: "4", serviceGroupId: "1", name: "Aroma oil massege", description: descr, img: "img4", serviceOptions: serviceOptions, serviceDeliveries: [.bringItNow, .arrangeTime]),
//            Service(id: "5", hotelId: "5", serviceGroupId: "1", name: "Basic salt bath", description: descr, img: "img5", serviceOptions: serviceOptions, serviceDeliveries: [.bringItNow, .arrangeTime])
//        ]
    }
}
