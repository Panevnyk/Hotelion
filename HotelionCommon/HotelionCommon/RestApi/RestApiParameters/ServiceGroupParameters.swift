//
//  ServiceGroupParameters.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 16.11.2020.
//

import RestApiManager

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
