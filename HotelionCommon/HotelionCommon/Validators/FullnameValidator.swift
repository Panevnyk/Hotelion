//
//  FullnameValidator.swift
//  Hotelion
//
//  Created by Panevnyk Vlad on 3/14/20.

//

public struct FullnameValidator: ValidatorProtocol {
    public init() {}
    
    public func validate(_ object: String?) -> ValidationResult {
        guard let string = object, !string.isEmpty else {
            return .noResult
        }
        
        if string.count < 3 {
            return .error("Name is too short")
        }
        
        return .success
    }
}
