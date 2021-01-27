//
//  HotelLoader.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 20.01.2021.
//

import RestApiManager
import RxSwift
import RxCocoa

public protocol HotelLoaderProtocol {
    var resultPublisher: PublishRelay<Result<Hotel>> { get set }
    var isLoadingPublisher: BehaviorRelay<Bool> { get set }

    func loadHotel(hotelId: String, completion: @escaping (Result<Hotel>) -> Void)
    func loadHotel(code: String, completion: @escaping (Result<Hotel>) -> Void)
}

public class HotelLoader: HotelLoaderProtocol {
    // MARK: - Properties
    // Boundaries
    private let restApiManager: RestApiManager

    // Data
    public var resultPublisher = PublishRelay<Result<Hotel>>()
    public var isLoadingPublisher = BehaviorRelay<Bool>(value: false)

    // MARK: - Inits
    public init(restApiManager: RestApiManager, hotelId: String) {
        self.restApiManager = restApiManager

        loadHotel(hotelId: hotelId, completion: { _ in })
    }

    public init(restApiManager: RestApiManager, code: String) {
        self.restApiManager = restApiManager

        loadHotel(code: code, completion: { _ in })
    }

    // MARK: - Load
    public func loadHotel(hotelId: String, completion: @escaping (Result<Hotel>) -> Void) {
        isLoadingPublisher.accept(true)

        let parameters = HotelByIdParameters(id: hotelId)
        let method = HotelRestApiMethods.getHotelById(parameters)
        restApiManager.call(method: method, completion: { [weak self] (result: Result<Hotel>) in
            DispatchQueue.main.async {
                self?.isLoadingPublisher.accept(false)
                self?.resultPublisher.accept(result)
            }
        })
    }

    public func loadHotel(code: String, completion: @escaping (Result<Hotel>) -> Void) {
        isLoadingPublisher.accept(true)

        let parameters = HotelByCodeParameters(code: code)
        let method = HotelRestApiMethods.getHotelByCode(parameters)
        restApiManager.call(method: method, completion: { [weak self] (result: Result<Hotel>) in
            DispatchQueue.main.async {
                self?.isLoadingPublisher.accept(false)
                self?.resultPublisher.accept(result)
            }
        })
    }
}
