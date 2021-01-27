//
//  PhoneNumberValidator.swift
//  Hotelion
//
//  Created by Panevnyk Vlad on 4/20/20.

//

import Foundation

public struct PhoneNumberValidator: ValidatorProtocol {
    public init() {}
    
    public func validate(_ object: String?) -> ValidationResult {
        guard let string = object, !string.isEmpty else {
            return .noResult
        }
        
        let emailRegex = "[0-9+]{6,}"
        
        if NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: string) {
            return .success
        } else {
            return .error("Phone number is incorrect")
        }
    }
}
