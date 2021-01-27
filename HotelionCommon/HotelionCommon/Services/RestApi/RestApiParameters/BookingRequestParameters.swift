//
//  CreateBookingRequestParameters.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 20.01.2021.
//

import RestApiManager

public struct CreateBookingRequestParameters: ParametersProtocol {
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
