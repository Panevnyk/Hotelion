//
//  ShortUserInfo.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 22.01.2021.
//

import Foundation

public final class ShortUserInfo: Decodable {
    public var id: String = ""
    public var email: String = ""
    public var firstname: String = ""
    public var lastname: String = ""

    public init(id: String,
                email: String,
                firstname: String,
                lastname: String) {
        self.id = id
        self.email = email
        self.firstname = firstname
        self.lastname = lastname
    }
}

