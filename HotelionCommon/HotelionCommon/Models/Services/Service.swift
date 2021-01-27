//
//  Service.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 03.12.2020.
//

public final class Service: Decodable {
    public var id: String
    public var hotelId: String
    public var serviceGroupId: String

    public var name: String
    public var description: String
    public var img: String

    public var serviceOptions: [ServiceOption]
    public var serviceDeliveries: [ServiceDelivery]

    public init(id: String,
                hotelId: String,
                serviceGroupId: String,
                name: String,
                description: String,
                img: String,
                serviceOptions: [ServiceOption],
                serviceDeliveries: [ServiceDelivery]) {
        self.id = id
        self.hotelId = hotelId
        self.serviceGroupId = serviceGroupId
        self.name = name
        self.description = description
        self.img = img
        self.serviceOptions = serviceOptions
        self.serviceDeliveries = serviceDeliveries
    }
}

public final class ServiceOption: Decodable {
    public var id: String
    public var name: String
    public var price: Double

    public init(id: String, name: String, price: Double) {
        self.id = id
        self.name = name
        self.price = price
    }
}

public enum ServiceDelivery: String, Decodable {
    case bringItNow = "bring_it_now"
    case arrangeTime = "arrange_time"
    case arrangeTimeRange = "arrange_time_range"

    public var title: String {
        switch self {
        case .bringItNow:
            return "Bring it now"
        case .arrangeTime:
            return "Arrange time"
        case .arrangeTimeRange:
            return "Arrange time range"
        }
    }
}
