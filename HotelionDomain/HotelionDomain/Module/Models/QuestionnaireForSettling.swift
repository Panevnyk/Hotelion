//
//  QuestionnaireForSettling.swift
//  HotelionDomain
//
//  Created by Vladyslav Panevnyk on 10.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation

public struct QuestionnaireForSettling {
    public let firstname: String
    public let secondname: String
    public let dateOfBirth: Date

    public init(firstname: String,
                secondname: String,
                dateOfBirth: Date) {
        self.firstname = firstname
        self.secondname = secondname
        self.dateOfBirth = dateOfBirth
    }
}
