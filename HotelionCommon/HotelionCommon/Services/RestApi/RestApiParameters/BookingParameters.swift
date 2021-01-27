//
//  CreateBookingParameters.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 03.12.2020.
//

import RestApiManager

public struct CreateBookingParameters: ParametersProtocol {
    public let hotelId: String
    public let serviceId: String
    public let serviceType: String
    public let optionId: String
    public let comment: String?
    public let startDate: Double?
    public let endDate: Double?

    public init(hotelId: String,
                serviceId: String,
                serviceType: String,
                optionId: String,
                comment: String?,
                startDate: Double?,
                endDate: Double?) {
        self.hotelId = hotelId
        self.serviceId = serviceId
        self.serviceType = serviceType
        self.optionId = optionId
        self.comment = comment
        self.startDate = startDate
        self.endDate = endDate
    }

    public var parametersValue: Parameters {
        var parameters: [String: Any] = [
            "hotelId": hotelId,
            "serviceId": serviceId,
            "serviceType": serviceType,
            "optionId": optionId
        ]

        if let comment = comment {
            parameters["comment"] = comment
        }

        if let startDate = startDate {
            parameters["startDate"] = startDate
        }

        if let endDate = endDate {
            parameters["endDate"] = endDate
        }

        return parameters
    }
}
