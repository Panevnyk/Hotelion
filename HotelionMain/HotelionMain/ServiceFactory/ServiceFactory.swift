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
    func makeHotelLoader(hotelId: String) -> HotelLoaderProtocol
    func makeHotelLoader(code: String) -> HotelLoaderProtocol
    func makeServicesLoader(hotelId: String) -> ServicesLoaderProtocol
    func makeBookingsLoader() -> BookingsLoaderProtocol
    func makeBookingRequestsLoader() -> BookingRequestsLoaderProtocol
}

final class ServiceFactory: NSObject, ServiceFactoryProtocol {
    var restApiManager: RestApiManager!
    var hotelLoader: HotelLoader!
    var serviceLoader: ServicesLoaderProtocol!
    var bookingsLoader: BookingsLoaderProtocol!
    var bookingRequestsLoader: BookingRequestsLoaderProtocol!

    override init() {
        super.init()

        let urlSession = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: self,
            delegateQueue: OperationQueue.main
        )
        restApiManager = URLSessionRestApiManager(
            urlSessionRAMDIContainer: URLSessionRAMDIContainer(
                errorType: CustomRestApiError.self,
                urlSession: urlSession,
                printRequestInfo: true
            )
        )
    }
}

// MARK: - URLSessionDelegate
extension ServiceFactory: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {

        if challenge.protectionSpace.host == "hotels.com" {
            completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }
}

// MARK: - ServiceFactoryProtocol
extension ServiceFactory {
    func makeRestApiManager() -> RestApiManager {
        return restApiManager
    }

    func makeHotelLoader(hotelId: String) -> HotelLoaderProtocol {
        if hotelLoader == nil {
            hotelLoader = HotelLoader(restApiManager: restApiManager,
                                      hotelId: hotelId)
        }
        return hotelLoader
    }

    func makeHotelLoader(code: String) -> HotelLoaderProtocol {
        if hotelLoader == nil {
            hotelLoader = HotelLoader(restApiManager: restApiManager,
                                      code: code)
        }
        return hotelLoader
    }
    
    func makeServicesLoader(hotelId: String) -> ServicesLoaderProtocol {
        if serviceLoader == nil {
            serviceLoader = ServicesLoader(restApiManager: restApiManager,
                                           hotelId: hotelId)
        }
        return serviceLoader
    }

    func makeBookingsLoader() -> BookingsLoaderProtocol {
        if bookingsLoader == nil {
            bookingsLoader = BookingsLoader(restApiManager: restApiManager)
        }
        return bookingsLoader
    }

    func makeBookingRequestsLoader() -> BookingRequestsLoaderProtocol {
        if bookingRequestsLoader == nil {
            bookingRequestsLoader = BookingRequestsLoader(restApiManager: restApiManager)
        }
        return bookingRequestsLoader
    }
}

