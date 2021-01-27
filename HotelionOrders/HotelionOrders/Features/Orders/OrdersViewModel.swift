//
//  OrdersViewModel.swift
//  HotelionOrders
//
//  Created by Vladyslav Panevnyk on 25.11.2020.
//

import RestApiManager
import RxSwift
import RxCocoa
import HotelionCommon

public protocol OrdersViewModelProtocol {
    var badgeValueObservable: Observable<String?> { get set }

    func reloadList(completion: @escaping () -> Void)
    func itemsCount(in section: Int) -> Int
    func orderViewModel(for item: Int) -> OrderViewModelProtocol
}

public protocol OrdersViewModelDelegate: class {
    func reloadData()
}

public class OrdersViewModel: OrdersViewModelProtocol {
    // MARK: - Properties
    // Boundaries
    private let restApiManager: RestApiManager
    private let servicesLoader: ServicesLoaderProtocol
    private let bookingsLoader: BookingsLoaderProtocol
    private let currentBooking: Booking

    // Rx
    private let badgeValue = BehaviorRelay<String?>(value: nil)
    lazy public var badgeValueObservable = badgeValue.asObservable()

    // Models
    private var bookings: [Booking] = [] {
        didSet { makeOrders() }
    }
    private var services: [Service] = [] {
        didSet { makeOrders() }
    }
    private var orders: [OrderViewModel] = []

    // DisposeBag
    private let disposeBag = DisposeBag()

    // Delegate
    public weak var delegate: OrdersViewModelDelegate?

    // MARK: - Inits
    public init(restApiManager: RestApiManager,
                servicesLoader: ServicesLoaderProtocol,
                bookingsLoader: BookingsLoaderProtocol,
                currentBooking: Booking) {
        self.restApiManager = restApiManager
        self.servicesLoader = servicesLoader
        self.bookingsLoader = bookingsLoader
        self.currentBooking = currentBooking

        bindData()
    }
}

// MARK: - Make order view model
private extension OrdersViewModel {
    func makeOrders() {
        guard services.count > 0 else { return }
        guard bookings.count > 0 else { return }

        orders = bookings
            .compactMap({ booking in
                guard let service = services.first(where: { $0.id == booking.roomId }),
                      let selectedOption = service.serviceOptions.first(where: { $0.id == booking.roomId })
                        else { return nil }

                return OrderViewModel(
                    img: service.img,
                    name: service.name,
                    price: String(selectedOption.price),
                    currency: "грн",
                    status: .confirmed,
                    deliveryDescription: "Without delivery",
                    deliveryDate: "Today at 9:00 PM",
                    creationDate: booking.creationDate
                )
            })
            .sorted(by: { $0.creationDate > $1.creationDate })

        delegate?.reloadData()

        badgeValue.accept(orders.count > 0 ? String(orders.count) : nil)
    }
}

// MARK: - Public methods
extension OrdersViewModel {
    public func itemsCount(in section: Int) -> Int {
        return orders.count
    }

    public func orderViewModel(for item: Int) -> OrderViewModelProtocol {
        return orders[item]
    }

    public func reloadList(completion: @escaping () -> Void) {
        bookingsLoader.loadBookings { _ in completion() }
    }
}

// MARK: - RestApiable
extension OrdersViewModel {
    func bindData() {
        servicesLoader.resultPublisher.bind { [weak self] (result) in
            switch result {
            case .success(let res):
                self?.services = res.services
            case .failure(let error):
                NotificationBannerHelper.showBanner(error)
            }
        }.disposed(by: disposeBag)

        bookingsLoader.resultPublisher.bind { [weak self] (result) in
            switch result {
            case .success(let bookings):
                self?.bookings = bookings
            case .failure(let error):
                NotificationBannerHelper.showBanner(error)
            }
        }.disposed(by: disposeBag)
    }
}
