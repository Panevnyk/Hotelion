//
//  AuthParameters.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 12.11.2020.
//

import RestApiManager

public struct SigninParameters: ParametersProtocol {
    public let email: String
    public let password: String

    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }

    public var parametersValue: Parameters {
        let parameters: [String: Any] = [
            RestApiConstants.email: email,
            RestApiConstants.password: password,
            ]
        return parameters
    }
}

public struct SignupParameters: ParametersProtocol {
    public let email: String
    public let password: String
//    let fullName: String

    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }

    public var parametersValue: Parameters {
        let parameters: [String: Any] = [
            RestApiConstants.email: email,
            RestApiConstants.password: password/*,
            RestApiConstants.fullName: fullName*/
            ]
        return parameters
    }
}

public struct ForgotPasswordParameters: ParametersProtocol {
    public let email: String

    public init(email: String, password: String) {
        self.email = email
    }

    public var parametersValue: Parameters {
        let parameters: [String: Any] = [
            RestApiConstants.email: email,
            ]
        return parameters
    }
}
