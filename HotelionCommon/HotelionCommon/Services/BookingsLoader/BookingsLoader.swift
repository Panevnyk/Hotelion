//
//  BookingsLoader.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 04.12.2020.
//

import RestApiManager
import RxSwift
import RxCocoa

public protocol BookingsLoaderProtocol {
    var resultPublisher: BehaviorRelay<Result<[Booking]>> { get set }
    var isLoadingPublisher: BehaviorRelay<Bool> { get set }

    func loadBookings(completion: @escaping (Result<[Booking]>) -> Void)
}

public final class BookingsLoader: BookingsLoaderProtocol {
    // MARK: - Properties
    // Boundaries
    private let restApiManager: RestApiManager

    // Data
    public var resultPublisher = BehaviorRelay<Result<[Booking]>>(value: .success([]))
    public var isLoadingPublisher = BehaviorRelay<Bool>(value: false)

    // MARK: - Inits
    public init(restApiManager: RestApiManager) {
        self.restApiManager = restApiManager
    }

    // MARK: - Load
    public func loadBookings(completion: @escaping (Result<[Booking]>) -> Void) {
        isLoadingPublisher.accept(true)

        restApiManager.call(method: BookingRestApiMethods.getList,
                            completion: { [weak self] (result: Result<[Booking]>) in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.isLoadingPublisher.accept(false)
                self.resultPublisher.accept(result)
                completion(result)
            }
        })
    }
}
