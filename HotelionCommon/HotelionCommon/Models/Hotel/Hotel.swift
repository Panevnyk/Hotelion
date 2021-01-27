//
//  Hotel.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 19.01.2021.
//

import Foundation

public final class Hotel: Decodable {
    public var id: String
    public var name: String
    public var code: String
    public var rooms: [Room]

    // MARK: - Init
    public init(id: String,
                name: String,
                code: String,
                rooms: [Room]) {
        self.id = id
        self.name = name
        self.code = code
        self.rooms = rooms
    }
}
