//
//  BookingRequestsLoader.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 20.01.2021.
//

import RestApiManager
import RxSwift
import RxCocoa

public protocol BookingRequestsLoaderProtocol {
    var resultPublisher: BehaviorRelay<Result<[BookingRequest]>> { get set }
    var isLoadingPublisher: BehaviorRelay<Bool> { get set }

    func loadBookingRequests(completion: ((Result<[BookingRequest]>) -> Void)?)
    func createBookingRequest(hotelId: String, completion: ((Result<BookingRequest>) -> Void)?)
}

public final class BookingRequestsLoader: BookingRequestsLoaderProtocol {
    // MARK: - Properties
    // Boundaries
    private let restApiManager: RestApiManager

    // Data
    public var resultPublisher = BehaviorRelay<Result<[BookingRequest]>>(value: .success([]))
    public var isLoadingPublisher = BehaviorRelay<Bool>(value: false)

    // MARK: - Inits
    public init(restApiManager: RestApiManager) {
        self.restApiManager = restApiManager
    }

    // MARK: - Load
    public func loadBookingRequests(completion: ((Result<[BookingRequest]>) -> Void)? = nil) {
        isLoadingPublisher.accept(true)

        let method = BookingRestApiMethods.bookingRequests
        restApiManager.call(method: method,
                            completion: { [weak self] (result: Result<[BookingRequest]>) in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.isLoadingPublisher.accept(false)
                self.resultPublisher.accept(result)
                completion?(result)
            }
        })
    }

    public func createBookingRequest(hotelId: String, completion: ((Result<BookingRequest>) -> Void)? = nil) {
        let parameters = CreateBookingRequestParameters(hotelId: hotelId)
        let method = BookingRestApiMethods.createBookingRequest(parameters)

        restApiManager.call(method: method) { [weak self] (result: Result<BookingRequest>) in
            guard let self = self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success(let newBookingRequest):
                    switch self.resultPublisher.value {
                    case .success(var bookingRequests):
                        bookingRequests.insert(newBookingRequest, at: 0)
                        self.resultPublisher.accept(.success(bookingRequests))
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
}
