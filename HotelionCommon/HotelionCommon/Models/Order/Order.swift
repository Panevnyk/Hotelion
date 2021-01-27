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
    public let user: User
    public let serviceId: String
    public let serviceType: String
    public let optionId: String
    public let creationDate: Double
    public let comment: String?
    public let startDate: Double?
    public let endDate: Double?
    public let bookingStatus: BookingStatus

    public init(id: String,
                userId: String,
                user: User,
                hotelId: String,
                serviceId: String,
                serviceType: String,
                optionId: String,
                creationDate: Double,
                comment: String?,
                startDate: Double,
                endDate: Double,
                bookingStatus: BookingStatus) {
        self.id = id
        self.userId = userId
        self.user = user
        self.hotelId = hotelId
        self.serviceId = serviceId
        self.serviceType = serviceType
        self.optionId = optionId
        self.creationDate = creationDate
        self.comment = comment
        self.startDate = startDate
        self.endDate = endDate
        self.bookingStatus = bookingStatus
    }
}

public enum BookingStatus: String, Decodable {
    case waiting = "waiting"
    case confirmed = "confirmed"
    case canceled = "cancelled"
    case completed = "completed"
}
