//
//  PassportNumberValidator.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 25.01.2021.
//

import UIKit

public struct PassportNumberValidator: ValidatorProtocol {
    public init() {}

    public func validate(_ object: String?) -> ValidationResult {
        guard let string = object, !string.isEmpty else {
            return .noResult
        }

        if string.count < 8 {
            return .error("Passport number is too short")
        }

        return .success
    }
}
