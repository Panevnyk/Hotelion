//
//  OrderRestApiMethods.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 28.01.2021.
//

import RestApiManager

public enum OrderRestApiMethods: RestApiMethod {
    // Method
    case getList
    case create(CreateOrderParameters)
    case remove(RemoveOrderParameters)

    // URL
    private static let getListURL = "/api/orders/current"
    private static let createURL = "/api/orders"
    private static let removeURL = "/api/orders"

    // RestApiData
    public var data: RestApiData {
        switch self {
        case .getList:
            return RestApiData(url: RestApiConstants.baseURL + OrderRestApiMethods.getListURL,
                               httpMethod: .get,
                               headers: defaultHeaders)
        case .create(let parameters):
            return RestApiData(url: RestApiConstants.baseURL + OrderRestApiMethods.createURL,
                               httpMethod: .post,
                               headers: defaultHeaders,
                               parameters: parameters)
        case .remove(let parameters):
            return RestApiData(url: RestApiConstants.baseURL
                                + OrderRestApiMethods.removeURL
                                + "/"
                                + parameters.orderId,
                               httpMethod: .delete,
                               headers: defaultHeaders)
        }
    }
}
