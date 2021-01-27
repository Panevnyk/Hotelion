//
//  ServicesListViewModel.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 13.11.2020.
//

import RestApiManager
import RxSwift
import RxCocoa
import HotelionCommon

public enum SectionCollectionType: Int, CaseIterable {
    case profile
    case hotel
    case services
}

public enum ServiceType: Int {
    case multiple
    case single
}

public protocol ServicesListViewModelDelegate: class {
    func reloadData()
}

public protocol ServiceItemsListViewModelFactory {
    func makeServiceItemsListViewModel(by index: Int) -> ServiceItemsListViewModelProtocol
}

public protocol ServicesListViewModelProtocol: ServiceItemsListViewModelFactory {
    func sectionCollectionType(by section: Int) -> SectionCollectionType?
    func serviceType(by index: Int) -> ServiceType
    func numberOfSection() -> Int
    func itemsCount(in section: Int) -> Int
    func profileCollectionViewModel(for item: Int) -> ProfileCollectionViewModelProtocol
    func servicesGroupViewModel(for item: Int) -> ServicesGroupItemViewModelProtocol
    func getServiceGroup(for item: Int) -> ServicesGroup
}

public final class ServicesListViewModel: ServicesListViewModelProtocol {
    // MARK: - Properties
    // Boundaries
    private let restApiManager: RestApiManager
    private let hotelLoader: HotelLoaderProtocol
    private let serviceLoader: ServicesLoaderProtocol
    private let currentBooking: Booking

    // Delegate
    public weak var delegate: ServicesListViewModelDelegate?

    // Models
    private var hotel: Hotel?
    private var serviceGroups: [ServicesGroup] = []
    private var services: [Service] = []

    // DisposeBag
    private let disposeBag = DisposeBag()

    // MARK: - Inits
    public init(restApiManager: RestApiManager,
                hotelLoader: HotelLoaderProtocol,
                serviceLoader: ServicesLoaderProtocol,
                currentBooking: Booking) {
        self.restApiManager = restApiManager
        self.hotelLoader = hotelLoader
        self.serviceLoader = serviceLoader
        self.currentBooking = currentBooking

        bindData()
    }
}

// MARK: - Public methods
extension ServicesListViewModel {
    public func sectionCollectionType(by section: Int) -> SectionCollectionType? {
        return SectionCollectionType(rawValue: section)
    }

    public func serviceType(by index: Int) -> ServiceType {
        switch index {
        case 0: return .multiple
        default: return .single
        }
    }

    public func numberOfSection() -> Int {
        return SectionCollectionType.allCases.count
    }

    public func itemsCount(in section: Int) -> Int {
        guard let servicesCollectionType = sectionCollectionType(by: section) else { return 0 }

        switch servicesCollectionType {
        case .profile, .hotel: return 1
        case .services: return serviceGroups.count + 1
        }
    }

    public func profileCollectionViewModel(for item: Int) -> ProfileCollectionViewModelProtocol {
        return ProfileCollectionViewModel(name: "Elena Smidt", livingDetails: "Room number: 112", avatar: "")
    }

    public func servicesGroupViewModel(for item: Int) -> ServicesGroupItemViewModelProtocol {
        let servicesGroup = getServiceGroup(for: item)

        return ServicesGroupItemViewModel(
            name: servicesGroup.name,
            img: servicesGroup.img
        )
    }

    public func getServiceGroup(for item: Int) -> ServicesGroup {
        return serviceGroups[item - 1]
    }
}

// MARK: - ServiceItemsListViewModelFactory
extension ServicesListViewModel: ServiceItemsListViewModelFactory {
    public func makeServiceItemsListViewModel(by index: Int) -> ServiceItemsListViewModelProtocol {
        let serviceGroup = getServiceGroup(for: index)
        let filteredServices = services.filter({ $0.serviceGroupId == serviceGroup.id })

        return ServiceItemsListViewModel(
            serviceGroup: serviceGroup,
            services: filteredServices
        )
    }
}

// MARK: - RestApiable
extension ServicesListViewModel {
    func bindData() {
        Observable.combineLatest(
            serviceLoader.isLoadingPublisher,
            hotelLoader.isLoadingPublisher
        ) { isLoadingService, isLoadingHotel in
            return isLoadingService || isLoadingHotel
        }.bind { (value) in
            if value {
                ActivityIndicatorHelper.shared.show()
            } else {
                ActivityIndicatorHelper.shared.hide()
            }
        }.disposed(by: disposeBag)

        hotelLoader.resultPublisher.bind { [weak self] (value) in
            switch value {
            case .success(let hotel):
                self?.hotel = hotel
            case .failure(let error):
                NotificationBannerHelper.showBanner(error)
            }

            self?.delegate?.reloadData()
        }.disposed(by: disposeBag)

        serviceLoader.resultPublisher.bind { [weak self] (value) in
            switch value {
            case .success(let res):
                self?.serviceGroups = res.serviceGroups
                self?.services = res.services
            case .failure(let error):
                NotificationBannerHelper.showBanner(error)
            }

            self?.delegate?.reloadData()
        }.disposed(by: disposeBag)
    }
}
