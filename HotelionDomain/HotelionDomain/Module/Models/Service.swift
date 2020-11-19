//
//  Service.swift
//  HotelionDomain
//
//  Created by Vladyslav Panevnyk on 14.08.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation

public struct Service {
    public var id: Int
    public var title: String
    public var img: String
    public var selectedDate: Date?

    public init(id: Int,
                title: String,
                img: String,
                selectedDate: Date? = nil) {
        self.id = id
        self.title = title
        self.img = img
        self.selectedDate = selectedDate
    }
}
