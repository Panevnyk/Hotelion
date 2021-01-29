//
//  Order.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 13.01.2021.
//

public final class Order: Decodable {
    public let id: String
    public let hotelId: String
    public let userId: String
    public let user: ShortUserInfo
    public let serviceId: String
    public let optionId: String
    public let creationDate: Double
    public let comment: String?
    public let startDate: Double
    public let endDate: Double?
    public let orderStatus: OrderStatus

    public init(id: String,
                userId: String,
                user: ShortUserInfo,
                hotelId: String,
                serviceId: String,
                optionId: String,
                creationDate: Double,
                comment: String?,
                startDate: Double,
                endDate: Double?,
                orderStatus: OrderStatus) {
        self.id = id
        self.userId = userId
        self.user = user
        self.hotelId = hotelId
        self.serviceId = serviceId
        self.optionId = optionId
        self.creationDate = creationDate
        self.comment = comment
        self.startDate = startDate
        self.endDate = endDate
        self.orderStatus = orderStatus
    }
}

public enum OrderStatus: String, Decodable {
    case waiting = "waiting"
    case confirmed = "confirmed"
    case canceled = "canceled"
    case completed = "completed"
}
