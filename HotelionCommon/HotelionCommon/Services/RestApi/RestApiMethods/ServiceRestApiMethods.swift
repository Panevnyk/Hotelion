//
//  ServiceRestApiMethods.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 30.11.2020.
//

import RestApiManager

public enum ServiceRestApiMethods: RestApiMethod {
    // Method
    case getList(ServiceParameters)
    case getServicesAndGroups(ServicesAndGroupsParameters)

    // URL
    private static let getListURL = "/api/services"
    private static let getServicesAndGroups = "/api/services/servicesAndGroups"

    // RestApiData
    public var data: RestApiData {
        switch self {
        case .getList(let parameters):
            return RestApiData(url: RestApiConstants.baseURL
                                + ServiceRestApiMethods.getListURL
                                + "/"
                                + parameters.serviceGroupId,
                               httpMethod: .get,
                               headers: defaultHeaders)
        case .getServicesAndGroups(let parameters):
            return RestApiData(url: RestApiConstants.baseURL
                                + ServiceRestApiMethods.getServicesAndGroups
                                + "/"
                                + parameters.hotelId,
                               httpMethod: .get,
                               headers: defaultHeaders)
        }
    }
}
