//
//  ServiceParameters.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 30.11.2020.
//

import RestApiManager

public struct ServiceParameters: ParametersProtocol {
    public let serviceGroupId: String

    public init(serviceGroupId: String) {
        self.serviceGroupId = serviceGroupId
    }

    public var parametersValue: Parameters {
        let parameters: [String: Any] = [
            RestApiConstants.serviceGroupId: serviceGroupId
            ]
        return parameters
    }
}

public struct ServicesAndGroupsParameters: ParametersProtocol {
    public let hotelId: String

    public init(hotelId: String) {
        self.hotelId = hotelId
    }

    public var parametersValue: Parameters {
        let parameters: [String: Any] = [
            RestApiConstants.hotelId: hotelId
            ]
        return parameters
    }
}

public struct ServiceGroupParameters: ParametersProtocol {
    public let hotelId: String

    public init(hotelId: String) {
        self.hotelId = hotelId
    }

    public var parametersValue: Parameters {
        let parameters: [String: Any] = [
            RestApiConstants.hotelId: hotelId
            ]
        return parameters
    }
}
