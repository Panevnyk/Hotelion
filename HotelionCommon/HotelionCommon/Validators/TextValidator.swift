//
//  TextValidator.swift
//  Hotelion
//
//  Created by Panevnyk Vlad on 3/14/20.

//

public struct TextValidator: ValidatorProtocol {
    private let errorText: String

    public init() {
        self.errorText = "Text is too short"
    }
    public init(errorText: String) {
        self.errorText = errorText
    }
    
    public func validate(_ object: String?) -> ValidationResult {
        guard let string = object, !string.isEmpty else {
            return .noResult
        }
        
        if string.count < 3 {
            return .error(errorText)
        }
        
        return .success
    }
}
