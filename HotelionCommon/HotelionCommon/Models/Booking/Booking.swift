//
//  Booking.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 26.11.2020.
//

public final class Booking: Decodable {
    public let id: String
    public let hotelId: String
    public let userId: String
    public let user: ShortUserInfo
    public let roomId: String
    public let guestsCount: Int
    public let startDate: Double
    public let endDate: Double
    public let creationDate: Double

    public init(id: String,
                hotelId: String,
                userId: String,
                user: ShortUserInfo,
                roomId: String,
                guestsCount: Int,
                startDate: Double,
                endDate: Double,
                creationDate: Double) {
        self.id = id
        self.hotelId = hotelId
        self.userId = userId
        self.user = user
        self.roomId = roomId
        self.guestsCount = guestsCount
        self.startDate = startDate
        self.endDate = endDate
        self.creationDate = creationDate
    }
}
