//
//  ServicesGroup.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 03.12.2020.
//

public final class ServicesGroup: Decodable {
    public var id: String
    public var hotelId: String
    public var name: String
    public var img: String

    public init(id: String, hotelId: String, name: String, img: String) {
        self.id = id
        self.hotelId = hotelId
        self.name = name
        self.img = img
    }
}
