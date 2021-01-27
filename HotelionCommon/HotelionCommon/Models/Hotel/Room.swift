//
//  Room.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 19.01.2021.
//

import Foundation

public final class Room: Decodable {
    public var id: String
    public var name: String
    public var hotelId: String

    // MARK: - Init
    public init(id: String,
                name: String,
                hotelId: String) {
        self.id = id
        self.name = name
        self.hotelId = hotelId
    }
}
