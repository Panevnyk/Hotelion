//
//  CodeValidator.swift
//  Hotelion
//
//  Created by Vladyslav Panevnyk on 16.03.18.

//

import Foundation

public struct CodeValidator: ValidatorProtocol {
    public init() {}
    
    public func validate(_ object: String?) -> ValidationResult {
        guard let string = object, !string.isEmpty else {
            return .noResult
        }
        
        if string.count < 6 {
            return .error("Code is not valid")
        }
        
        return .success
    }
}
