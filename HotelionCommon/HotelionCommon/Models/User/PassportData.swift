//
//  PassportData.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 22.01.2021.
//

import Foundation

public final class RetouchGroup: Decodable {
    public var id: String
    public var number: String
    public var image: String
    public var price: Double

    // MARK: - Init
    public init(id: String,
                number: String,
                image: String,
                price: Double
    ) {
        self.id = id
        self.number = number
        self.image = image
        self.price = price
    }
}
