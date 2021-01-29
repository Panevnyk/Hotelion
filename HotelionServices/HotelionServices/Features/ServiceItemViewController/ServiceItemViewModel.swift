//
//  ServiceItemViewModel.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 17.11.2020.
//

import RxSwift
import RxCocoa
import RestApiManager
import HotelionCommon

public protocol ServiceItemViewModelProtocol {
    var service: BehaviorRelay<Service> { get }

    var isDescriptionBlockHiddenObservable: Observable<Bool> { get }
    var descriptionTextObservable: Observable<String> { get }
    var totalPriceObservable: Observable<String> { get }
    var startDeliveryDate: BehaviorRelay<Date> { get }
    var endDeliveryDate: BehaviorRelay<Date?> { get }
    var deliveryTime: Observable<String> { get }

    var commentText: BehaviorRelay<String?> {  get set }

    func getTitle() -> String
    func getHeaderImages() -> [String]
    func getService() -> Service
    func getServiceOptions() -> [OptionModel]
    func getDeliveryOptions() -> [OptionModel]
    func getServiceDelivery(by item: Int) -> ServiceDelivery

    func didSelectServiceOption(by item: Int)
    func didSelectBringItNowDeliveryOption()
    func didSelectArrangeTimeDeliveryOption(startDeliveryDate: Date)
    func didSelectArrangeTimeRangeDeliveryOption(startDeliveryDate: Date, endDeliveryDate: Date)
    func didTapOrder()
}

public final class ServiceItemViewModel: ServiceItemViewModelProtocol {
    // MARK: - Properties
    // Boundaries
    private let restApiManager: RestApiManager
    private let ordersLoader: OrdersLoaderProtocol
    private let currentBooking: Booking

    // Formatters
    private let dateAndTimeFormatter = DateHelper.shared.dateAndTimeStyleFormatter

    // Rx
    public let service: BehaviorRelay<Service>

    private let descriptionText: BehaviorRelay<String>
    lazy public var descriptionTextObservable =
        descriptionText.asObservable()
    lazy public var isDescriptionBlockHiddenObservable =
        descriptionText.map{ $0.isEmpty }.asObservable()

    private let totalPrice: BehaviorRelay<String>
    lazy public var totalPriceObservable = totalPrice.asObservable()

    public var commentText = BehaviorRelay<String?>(value: nil)

    public let startDeliveryDate: BehaviorRelay<Date>
    public let endDeliveryDate: BehaviorRelay<Date?>
    public var deliveryTime: Observable<String> {
        return Observable.combineLatest(startDeliveryDate, endDeliveryDate)
        { startDate, endDate in
            return self.makeDeliveryTime(startDeliveryDate: startDate,
                                         endDeliveryDate: endDate)
        }
    }

    // Selected
    private var selectedServiceItem = 0 {
        didSet { selectedServiceItemUpdated() }
    }
    private var selectedDeliveryItem = 0 {
        didSet { selectedDeliveryItemUpdated() }
    }

    // DisposeBag
    let disposeBag = DisposeBag()

    // MARK: - Init
    public init(service: Service,
                restApiManager: RestApiManager,
                ordersLoader: OrdersLoaderProtocol,
                currentBooking: Booking) {
        self.service = BehaviorRelay<Service>(value: service)
        self.restApiManager = restApiManager
        self.ordersLoader = ordersLoader
        self.currentBooking = currentBooking

        descriptionText = BehaviorRelay<String>(value: service.description)
        totalPrice = BehaviorRelay<String>(value: "")
        
        startDeliveryDate = BehaviorRelay<Date>(value: service.makeStartDate())
        endDeliveryDate = BehaviorRelay<Date?>(value: nil)

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
        return ["icHotelPlaceholderBig", "icHotelPlaceholderBig", "icHotelPlaceholderBig"]
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

    func getServiceDelivery(by item: Int) -> ServiceDelivery {
        return service.value.serviceDeliveries[item]
    }

    func didSelectBringItNowDeliveryOption() {
        self.startDeliveryDate.accept(service.value.makeStartDate())
        self.endDeliveryDate.accept(nil)
    }

    func didSelectArrangeTimeDeliveryOption(startDeliveryDate: Date) {
        self.startDeliveryDate.accept(startDeliveryDate)
        self.endDeliveryDate.accept(nil)
    }

    func didSelectArrangeTimeRangeDeliveryOption(startDeliveryDate: Date, endDeliveryDate: Date) {
        self.startDeliveryDate.accept(startDeliveryDate)
        self.endDeliveryDate.accept(endDeliveryDate)
    }

    func didTapOrder() {
        let parameters = CreateOrderParameters(
            hotelId: currentBooking.hotelId,
            serviceId: service.value.id,
            optionId: service.value.serviceOptions[selectedServiceItem].id,
            comment: commentText.value,
            startDate: startDeliveryDate.value.timeIntervalSince1970MiliSec,
            endDate: endDeliveryDate.value?.timeIntervalSince1970MiliSec)

        ordersLoader.createOrder(parameters: parameters) { [weak self] (result: Result<Order>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                ActivityIndicatorHelper.shared.hide()

                switch result {
                case .success:
                    AlertHelper.show(title: "Order created successfuly",
                                     message: self.getService().name)
                case .failure(let error):
                    NotificationBannerHelper.showBanner(error)
                }
            }
        }
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

    func makeDeliveryTime(startDeliveryDate: Date, endDeliveryDate: Date?) -> String {
        let startFormattedDate = dateAndTimeFormatter.string(from: startDeliveryDate)

        let time: String
        if let endDeliveryDate = endDeliveryDate {
            let endFormattedDate = dateAndTimeFormatter.string(from: endDeliveryDate)

            time = startFormattedDate + " - " + endFormattedDate
        } else {
            time = startFormattedDate
        }

        return "(\(time))"
    }
}
