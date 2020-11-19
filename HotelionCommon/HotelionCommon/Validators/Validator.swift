//
//  Validator.swift
//  Hotelion
//
//  Created by Vladyslav Panevnyk on 12.03.18.

//

import Foundation

public enum ValidationResult {
    case noResult
    case success
    case error(String?)
}

public extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .error, .noResult:
            return false
        case .success:
            return true
        }
    }
}

public protocol ValidatorProtocol {
    func validate(_ object: String?) -> ValidationResult
}
