//
//  ServiceFactory.swift
//  HotelionMain
//
//  Created by Vladyslav Panevnyk on 10.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation
import RestApiManager
import HotelionCommon

protocol ServiceFactoryProtocol {
    func makeRestApiManager() -> RestApiManager
}

final class ServiceFactory: ServiceFactoryProtocol {
    let restApiManager: RestApiManager

    init() {
        restApiManager = URLSessionRestApiManager(
            urlSessionRAMDIContainer: URLSessionRAMDIContainer(
                errorType: CustomRestApiError.self,
                printRequestInfo: true
            )
        )
    }
}

// MARK: - ServiceFactoryProtocol
extension ServiceFactory {
    func makeRestApiManager() -> RestApiManager { restApiManager }
}

