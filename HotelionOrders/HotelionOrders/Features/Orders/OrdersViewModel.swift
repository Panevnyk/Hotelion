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

    func reloadList(completion: (() -> Void)?)
    func itemsCount(in section: Int) -> Int
    func orderViewModel(for item: Int) -> OrderViewModelProtocol

    func removeOrder(for item: Int)
}

public protocol OrdersViewModelDelegate: class {
    func reloadData()
}

public class OrdersViewModel: OrdersViewModelProtocol {
    // MARK: - Properties
    // Boundaries
    private let restApiManager: RestApiManager
    private let servicesLoader: ServicesLoaderProtocol
    private let ordersLoader: OrdersLoaderProtocol
    private let currentBooking: Booking

    // Formatters
    private let dateAndTimeFormatter = DateHelper.shared.dateAndTimeStyleFormatter

    // Rx
    private let badgeValue = BehaviorRelay<String?>(value: nil)
    lazy public var badgeValueObservable = badgeValue.asObservable()

    // Models
    private var orders: [Order] = [] {
        didSet { makeOrders() }
    }
    private var services: [Service] = [] {
        didSet { makeOrders() }
    }
    private var orderViewModels: [OrderViewModel] = []

    // DisposeBag
    private let disposeBag = DisposeBag()

    // Delegate
    public weak var delegate: OrdersViewModelDelegate?

    // MARK: - Inits
    public init(restApiManager: RestApiManager,
                servicesLoader: ServicesLoaderProtocol,
                ordersLoader: OrdersLoaderProtocol,
                currentBooking: Booking) {
        self.restApiManager = restApiManager
        self.servicesLoader = servicesLoader
        self.ordersLoader = ordersLoader
        self.currentBooking = currentBooking

        bindData()
        reloadList(completion: nil)
    }
}

// MARK: - Make order view model
private extension OrdersViewModel {
    func makeOrders() {
        orderViewModels = orders
            .compactMap({ order in
                guard let service = services.first(where: { $0.id == order.serviceId }),
                      let selectedOption = service.serviceOptions.first(where: { $0.id == order.optionId })
                        else { return nil }

                return OrderViewModel(
                    orderId: order.id,
                    img: service.img,
                    name: service.name,
                    price: String(selectedOption.price),
                    currency: "грн",
                    status: order.orderStatus,
                    deliveryDescription: "Without delivery",
                    deliveryDate: makeDeliveryDate(from: order),
                    creationDate: order.creationDate
                )
            })
            .sorted(by: { $0.creationDate > $1.creationDate })

        delegate?.reloadData()

        badgeValue.accept(orders.count > 0 ? String(orders.count) : nil)
    }

    func makeDeliveryDate(from order: Order) -> String {
        let startDate = Date(timeIntervalSince1970MiliSec: order.startDate)
        let startFormattedDate = dateAndTimeFormatter.string(from: startDate)

        let time: String
        if let orderEndDate = order.endDate {
            let endDate = Date(timeIntervalSince1970MiliSec: orderEndDate)
            let endFormattedDate = dateAndTimeFormatter.string(from: endDate)

            time = startFormattedDate + " - " + endFormattedDate
        } else {
            time = startFormattedDate
        }

        return time
    }
}

// MARK: - Public methods
extension OrdersViewModel {
    public func itemsCount(in section: Int) -> Int {
        return orders.count
    }

    public func orderViewModel(for item: Int) -> OrderViewModelProtocol {
        return orderViewModels[item]
    }

    public func reloadList(completion: (() -> Void)?) {
        ordersLoader.loadOrders { _ in completion?() }
    }

    public func removeOrder(for item: Int) {
        ActivityIndicatorHelper.shared.show()

        let orderId = orderViewModel(for: item).orderId
        ordersLoader.removeOrder(orderId: orderId) { (result) in
            ActivityIndicatorHelper.shared.hide()

            switch result {
            case .success:
                break
            case .failure(let error):
                NotificationBannerHelper.showBanner(error)
            }
        }
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

        ordersLoader.resultPublisher.bind { [weak self] (result) in
            switch result {
            case .success(let orders):
                self?.orders = orders
            case .failure(let error):
                NotificationBannerHelper.showBanner(error)
            }
        }.disposed(by: disposeBag)
    }
}
