//
//  ServicesListViewModel.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 13.11.2020.
//

import Foundation
import RestApiManager
import HotelionCommon

public enum ServicesCollectionType: Int {
    case hotel
    case services
}

public protocol ServicesListViewModelProtocol {
    func servicesCollectionType(by section: Int) -> ServicesCollectionType?
    func numberOfSection() -> Int
    func itemsCount(in section: Int) -> Int
    func servicesGroupViewModel(for item: Int) -> ServicesGroupItemViewModelProtocol
    func getServiceGroup(for item: Int) -> ServicesGroup
}

public final class ServicesListViewModel: ServicesListViewModelProtocol {
    // MARK: - Properties
    // Boundaries
    private let restApiManager: RestApiManager

    // Models
    private var servicesGroups: [ServicesGroup] = []

    // MARK: - Inits
    public init(restApiManager: RestApiManager) {
        self.restApiManager = restApiManager
        loadServicesList()
    }
}

// MARK: - Public methods
extension ServicesListViewModel {
    public func servicesCollectionType(by section: Int) -> ServicesCollectionType? {
        return ServicesCollectionType(rawValue: section)
    }

    public func numberOfSection() -> Int {
        return 2
    }

    public func itemsCount(in section: Int) -> Int {
        guard let servicesCollectionType = servicesCollectionType(by: section) else { return 0 }

        switch servicesCollectionType {
        case .hotel:
            return 1
        case .services:
            return servicesGroups.count
        }
    }

    public func servicesGroupViewModel(for item: Int) -> ServicesGroupItemViewModelProtocol {
        let servicesGroup = getServiceGroup(for: item)

        return ServicesGroupItemViewModel(
            name: servicesGroup.name.uppercased(),
            img: servicesGroup.img
        )
    }

    public func getServiceGroup(for item: Int) -> ServicesGroup {
        return servicesGroups[item]
    }
}

// MARK: - RestApiable
extension ServicesListViewModel {
    public func loadServicesList() {
        servicesGroups = [
            ServicesGroup(id: "1", hotelId: "1", name: "Food", img: "icWakeUpCall"),
            ServicesGroup(id: "2", hotelId: "2", name: "Activity", img: "icTaxi"),
            ServicesGroup(id: "3", hotelId: "3", name: "Room service", img: "icTowelReplacement"),
            ServicesGroup(id: "4", hotelId: "4", name: "Cleaning", img: "icCleaning"),
            ServicesGroup(id: "5", hotelId: "5", name: "Hotel shop", img: "icWashing")
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
