//
//  BookingRestApiMethods.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 26.11.2020.
//

import RestApiManager

public enum BookingRestApiMethods: RestApiMethod {
    // Method
    case getList
    case create(CreateBookingParameters)
    case createBookingRequest(CreateBookingRequestParameters)
    case bookingRequests

    // URL
    private static let getListURL = "/api/bookings/current"
    private static let createURL = "/api/bookings"
    private static let createBookingRequestURL = "/api/bookings/requests"
    private static let bookingRequestsURL = "/api/bookings/requests/current"

    // RestApiData
    public var data: RestApiData {
        switch self {
        case .getList:
            return RestApiData(url: RestApiConstants.baseURL + BookingRestApiMethods.getListURL,
                               httpMethod: .get,
                               headers: defaultHeaders)
        case .create(let parameters):
            return RestApiData(url: RestApiConstants.baseURL + BookingRestApiMethods.createURL,
                               httpMethod: .post,
                               headers: defaultHeaders,
                               parameters: parameters)
        case .createBookingRequest(let parameters):
            return RestApiData(url: RestApiConstants.baseURL + BookingRestApiMethods.createBookingRequestURL,
                               httpMethod: .post,
                               headers: defaultHeaders,
                               parameters: parameters)
        case .bookingRequests:
            return RestApiData(url: RestApiConstants.baseURL
                                + BookingRestApiMethods.bookingRequestsURL,
                               httpMethod: .get,
                               headers: defaultHeaders)
        }
    }
}
