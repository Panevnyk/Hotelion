//
//  ServicesLoader.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 03.12.2020.
//

import RestApiManager
import RxSwift
import RxCocoa

public protocol ServicesLoaderProtocol {
    var resultPublisher: BehaviorRelay<Result<ServicesLoaderResult>> { get set }
    var isLoadingPublisher: BehaviorRelay<Bool> { get set }
}

public class ServicesLoader: ServicesLoaderProtocol {
    // MARK: - Properties
    // Boundaries
    private let restApiManager: RestApiManager
    private let hotelId: String

    // Data
    public var resultPublisher = BehaviorRelay<Result<ServicesLoaderResult>>(
        value: Result.success(ServicesLoaderResult(serviceGroups: [], services: []))
    )
    public var isLoadingPublisher = BehaviorRelay<Bool>(value: false)

    // MARK: - Inits
    public init(restApiManager: RestApiManager, hotelId: String) {
        self.restApiManager = restApiManager
        self.hotelId = hotelId

        loadServicesAndGroups()
    }

    // MARK: - Load
    private func loadServicesAndGroups() {
        isLoadingPublisher.accept(true)

        let parameters = ServicesAndGroupsParameters(hotelId: hotelId)
        let method = ServiceRestApiMethods.getServicesAndGroups(parameters)
        restApiManager.call(method: method, completion: { [weak self] (result: Result<ServicesLoaderResult>) in
            DispatchQueue.main.async {
                self?.isLoadingPublisher.accept(false)
                self?.resultPublisher.accept(result)
            }
        })
    }
}

public struct ServicesLoaderResult: Decodable {
    public var serviceGroups: [ServicesGroup]
    public var services: [Service]
}

