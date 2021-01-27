//
//  BookingRequest.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 20.01.2021.
//

import UIKit

public final class BookingRequest: Decodable {
    public var id: String
    public var userId: String
    public var hotelId: String
    public var user: ShortUserInfo

    // MARK: - Init
    public init(id: String,
                userId: String,
                hotelId: String,
                user: ShortUserInfo
    ) {
        self.id = id
        self.userId = userId
        self.hotelId = hotelId
        self.user = user
    }
}
