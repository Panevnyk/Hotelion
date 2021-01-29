//
//  OrderParameters.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 28.01.2021.
//

import UIKit
import RestApiManager

public struct CreateOrderParameters: ParametersProtocol {
    public let hotelId: String
    public let serviceId: String
    public let optionId: String
    public let comment: String?
    public let startDate: Double?
    public let endDate: Double?

    public init(hotelId: String,
                serviceId: String,
                optionId: String,
                comment: String?,
                startDate: Double?,
                endDate: Double?) {
        self.hotelId = hotelId
        self.serviceId = serviceId
        self.optionId = optionId
        self.comment = comment
        self.startDate = startDate
        self.endDate = endDate
    }

    public var parametersValue: Parameters {
        var parameters: [String: Any] = [
            "hotelId": hotelId,
            "serviceId": serviceId,
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

public struct RemoveOrderParameters: ParametersProtocol {
    public let orderId: String

    public init(orderId: String) {
        self.orderId = orderId
    }

    public var parametersValue: Parameters {
        let parameters: [String: Any] = [
            "orderId": orderId
        ]

        return parameters
    }
}
