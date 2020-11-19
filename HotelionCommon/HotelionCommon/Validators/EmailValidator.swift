//
//  EmailValidator.swift
//  Hotelion
//
//  Created by Vladyslav Panevnyk on 12.03.18.

//

import Foundation

public struct EmailValidator: ValidatorProtocol {
    public init() {}

    public func validate(_ object: String?) -> ValidationResult {
        guard let string = object, !string.isEmpty else {
            return .noResult
        }

        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,63}"
        
        if NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: string) {
            return .success
        } else {
            return .error("Email is incorrect")
        }
    }
}
