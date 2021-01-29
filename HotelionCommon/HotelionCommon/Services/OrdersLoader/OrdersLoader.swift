//
//  OrdersLoader.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 28.01.2021.
//

import RestApiManager
import RxSwift
import RxCocoa

public protocol OrdersLoaderProtocol {
    var resultPublisher: BehaviorRelay<Result<[Order]>> { get set }
    var isLoadingPublisher: BehaviorRelay<Bool> { get set }

    func loadOrders(completion: ((Result<[Order]>) -> Void)?)
    func createOrder(parameters: CreateOrderParameters, completion: ((Result<Order>) -> Void)?)
    func removeOrder(orderId: String, completion: ((Result<Void>) -> Void)?)
}

public final class OrdersLoader: OrdersLoaderProtocol {
    // MARK: - Properties
    // Boundaries
    private let restApiManager: RestApiManager

    // Data
    public var resultPublisher = BehaviorRelay<Result<[Order]>>(value: .success([]))
    public var isLoadingPublisher = BehaviorRelay<Bool>(value: false)

    // MARK: - Inits
    public init(restApiManager: RestApiManager) {
        self.restApiManager = restApiManager
    }

    // MARK: - Load
    public func loadOrders(completion: ((Result<[Order]>) -> Void)? = nil) {
        isLoadingPublisher.accept(true)

        let method = OrderRestApiMethods.getList
        restApiManager.call(method: method,
                            completion: { [weak self] (result: Result<[Order]>) in
                                guard let self = self else { return }

                                DispatchQueue.main.async {
                                    self.isLoadingPublisher.accept(false)
                                    self.resultPublisher.accept(result)
                                    completion?(result)
                                }
                            })
    }

    public func createOrder(parameters: CreateOrderParameters, completion: ((Result<Order>) -> Void)? = nil) {
        let method = OrderRestApiMethods.create(parameters)

        isLoadingPublisher.accept(true)
        restApiManager.call(method: method) { [weak self] (result: Result<Order>) in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.isLoadingPublisher.accept(false)

                switch result {
                case .success(let newOrder):
                    switch self.resultPublisher.value {
                    case .success(var orders):
                        orders.insert(newOrder, at: 0)
                        self.resultPublisher.accept(.success(orders))
                    case .failure:
                        break
                    }
                case .failure:
                    break
                }

                completion?(result)
            }
        }
    }

    public func removeOrder(orderId: String, completion: ((Result<Void>) -> Void)?) {
        let parameters = RemoveOrderParameters(orderId: orderId)
        let method = OrderRestApiMethods.remove(parameters)

        isLoadingPublisher.accept(true)
        restApiManager.call(method: method) { [weak self] (result: Result<String>) in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.isLoadingPublisher.accept(false)

                switch result {
                case .success:
                    switch self.resultPublisher.value {
                    case .success(var orders):
                        if let index = orders.firstIndex(where: { $0.id == orderId }) {
                            orders.remove(at: index)
                        }
                        self.resultPublisher.accept(.success(orders))
                    case .failure:
                        break
                    }

                    completion?(.success(()))
                case .failure(let error):
                    completion?(.failure(error))
                }
            }
        }
    }
}

