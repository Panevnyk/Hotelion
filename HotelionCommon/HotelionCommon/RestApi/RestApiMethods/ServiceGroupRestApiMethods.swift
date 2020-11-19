//
//  ServiceGroupRestApiMethods.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 16.11.2020.
//

import RestApiManager

public enum ServiceGroupRestApiMethods: RestApiMethod {
    // Method
    case getList(ServiceGroupParameters)

    // URL
    private static let getListURL = "/api/services/groups"

    // RestApiData
    public var data: RestApiData {
        switch self {
        case .getList(let parameters):
            return RestApiData(url: RestApiConstants.baseURL + ServiceGroupRestApiMethods.getListURL,
                               httpMethod: .get,
                               headers: defaultHeaders,
                               parameters: parameters)
        }
    }
}
