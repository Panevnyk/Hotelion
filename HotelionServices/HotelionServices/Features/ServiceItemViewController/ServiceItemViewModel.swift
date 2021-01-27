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

    var commentText: BehaviorRelay<String?> {  get set }

    func getTitle() -> String
    func getHeaderImages() -> [String]
    func getService() -> Service
    func getServiceOptions() -> [OptionModel]
    func getDeliveryOptions() -> [OptionModel]

    func didSelectServiceOption(by item: Int)
    func didSelectDeliveryOption(by item: Int)
    func didTapOrder()
}

public final class ServiceItemViewModel: ServiceItemViewModelProtocol {
    // MARK: - Properties
    // Boundaries
    private let restApiManager: RestApiManager
    private let bookingsLoader: BookingsLoaderProtocol
    private let currentBooking: Booking

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
                restApiManager: RestApiManager,
                bookingsLoader: BookingsLoaderProtocol,
                currentBooking: Booking) {
        self.service = BehaviorRelay<Service>(value: service)
        self.restApiManager = restApiManager
        self.bookingsLoader = bookingsLoader
        self.currentBooking = currentBooking

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

    func didSelectDeliveryOption(by item: Int) {
        selectedDeliveryItem = item
    }

    func didTapOrder() {
//        let dates = getStartAndEndDates()
//        let parameters = CreateBookingParameters(
//            hotelId: currentBooking.hotelId,
//            serviceId: service.value.id,
//            serviceType: "service",
//            optionId: service.value.serviceOptions[selectedServiceItem].id,
//            comment: commentText.value,
//            startDate: dates.startDate,
//            endDate: dates.endDate)
//        let method = BookingRestApiMethods.create(parameters)
//
//        ActivityIndicatorHelper.shared.show()
//        restApiManager.call(method: method) { [weak self] (result: Result<Booking>) in
//            guard let self = self else { return }
//            DispatchQueue.main.async {
//                ActivityIndicatorHelper.shared.hide()
//
//                switch result {
//                case .success(let booking):
//                    var newBookings = self.bookingsLoader.resultPublisher.value
//                    newBookings.insert(booking, at: 0)
//                    self.bookingsLoader.resultPublisher.accept(newBookings)
//
//                    AlertHelper.show(title: "Ordered successfully",
//                                     message: self.getService().name)
//
//                case .failure(let error):
//                    NotificationBannerHelper.showBanner(error)
//                }
//            }
//        }
    }

    func getStartAndEndDates() -> (startDate: Double?, endDate: Double?) {
        let serviceDelivery = service.value.serviceDeliveries[selectedDeliveryItem]
        switch serviceDelivery {
        case .bringItNow:
            return (startDate: nil, endDate: nil)
        case .arrangeTime:
            return (startDate: Date().timeIntervalSince1970, endDate: nil)
        case .arrangeTimeRange:
            return (startDate: Date().timeIntervalSince1970, endDate: Date().timeIntervalSince1970)
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
}
