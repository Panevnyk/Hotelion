//
//  HotelRestApiMethods.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 19.01.2021.
//

import RestApiManager

public enum HotelRestApiMethods: RestApiMethod {
    // Method
    case getHotelByCode(HotelByCodeParameters)
    case getHotelById(HotelByIdParameters)

    // URL
    private static let getHotelByCodeURL = "/api/hotels/code"
    private static let getHotelByIdURL = "/api/hotels"

    // RestApiData
    public var data: RestApiData {
        switch self {
        case .getHotelByCode(let parameters):
            return RestApiData(url: RestApiConstants.baseURL
                                + HotelRestApiMethods.getHotelByCodeURL
                                + "/"
                                + parameters.code,
                               httpMethod: .get,
                               headers: defaultHeaders)
        case .getHotelById(let parameters):
            return RestApiData(url: RestApiConstants.baseURL
                                + HotelRestApiMethods.getHotelByIdURL
                                + "/"
                                + parameters.id,
                               httpMethod: .get,
                               headers: defaultHeaders)
        }
    }
}
