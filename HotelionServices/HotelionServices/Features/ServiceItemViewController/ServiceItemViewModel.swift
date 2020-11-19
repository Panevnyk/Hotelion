//
//  ServiceItemViewModel.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 17.11.2020.
//

import RxSwift
import RxCocoa
import RestApiManager

public protocol ServiceItemViewModelProtocol {
    var service: BehaviorRelay<Service> { get }

    var descriptionTextObservable: Observable<String> { get }
    var totalPriceObservable: Observable<String> { get }

    func getTitle() -> String
    func getHeaderImages() -> [String]
    func getService() -> Service
    func getServiceOptions() -> [OptionModel]
    func getDeliveryOptions() -> [OptionModel]

    func didSelectServiceOption(by item: Int)
    func didSelectDeliveryOption(by item: Int)
}

public final class ServiceItemViewModel: ServiceItemViewModelProtocol {
    // MARK: - Properties
    // Boundaries
    private let restApiManager: RestApiManager

    // Rx
    public let service: BehaviorRelay<Service>

    private let descriptionText: BehaviorRelay<String>
    lazy public var descriptionTextObservable = descriptionText.asObservable()

    private let totalPrice: BehaviorRelay<String>
    lazy public var totalPriceObservable = totalPrice.asObservable()

    // Selected
    private var selectedServiceItem: Int = 0 {
        didSet { selectedServiceItemUpdated() }
    }
    private var selectedDeliveryItem: Int = 0 {
        didSet { selectedDeliveryItemUpdated() }
    }

    // DisposeBag
    let disposeBag = DisposeBag()

    // MARK: - Init
    public init(service: Service,
                restApiManager: RestApiManager) {
        self.service = BehaviorRelay<Service>(value: service)
        self.restApiManager = restApiManager

        descriptionText = BehaviorRelay<String>(value: service.description)
        totalPrice = BehaviorRelay<String>(value: "")

        selectedServiceItemUpdated()
        selectedDeliveryItemUpdated()
    }
}

// MARK: - Public methods
public extension ServiceItemViewModel {
    func getTitle() -> String {
        return service.value.name
    }

    func getHeaderImages() -> [String] {
        return ["icSPAResort", "icSPAResort", "icSPAResort"]
    }

    func getService() -> Service {
        return service.value
    }

    func getServiceOptions() -> [OptionModel] {
        return getService().serviceOptions.enumerated().map {
            OptionModel(id: String($0.offset), title: $0.element.name)
        }
    }

    func getDeliveryOptions() -> [OptionModel] {
        return getService().serviceDeliveries.enumerated().map {
            OptionModel(id: String($0.offset), title: $0.element.title)
        }
    }

    func didSelectServiceOption(by item: Int) {
        selectedServiceItem = item
    }

    func didSelectDeliveryOption(by item: Int) {
        selectedDeliveryItem = item
    }
}

// MARK: - Updates after selection
private extension ServiceItemViewModel {
    func selectedServiceItemUpdated() {
        let price = getServiceOptionPrice(by: selectedServiceItem)
        totalPrice.accept(price)
    }

    func selectedDeliveryItemUpdated() {

    }
}

// MARK: - Helpers
private extension ServiceItemViewModel {
    func getServiceOptionPrice(by index: Int) -> String {
        let price = getService().serviceOptions[selectedServiceItem].price
        return String(price)
    }
}
