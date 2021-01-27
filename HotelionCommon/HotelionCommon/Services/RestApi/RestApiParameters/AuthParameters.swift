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
    public let firstname: String
    public let lastname: String
    public let email: String
    public let phoneNumber: String
    public let password: String

    public init(firstname: String,
                lastname: String,
                email: String,
                phoneNumber: String,
                password: String
    ) {
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.phoneNumber = phoneNumber
        self.password = password
    }

    public var parametersValue: Parameters {
        let parameters: [String: Any] = [
            RestApiConstants.firstname: firstname,
            RestApiConstants.lastname: lastname,
            RestApiConstants.email: email,
            RestApiConstants.phoneNumber: phoneNumber,
            RestApiConstants.password: password
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
