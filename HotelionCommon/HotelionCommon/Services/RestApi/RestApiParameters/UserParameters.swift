//
//  CreateOrUpdateFullUserInfoParameters.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 19.01.2021.
//

import RestApiManager

public struct CreateOrUpdateFullUserInfoParameters: ParametersProtocol {
    public let email: String
    public let firstname: String
    public let lastname: String
    public let phoneNumber: String
    public let passportNumber: String
    public let passportFrom: String
    public let nationality: String
    public let placeOfResidence: String
    public let dateOfBirth: Double
    public let digitalSignature: String

    public init(email: String,
                firstname: String,
                lastname: String,
                phoneNumber: String,
                passportNumber: String,
                passportFrom: String,
                nationality: String,
                placeOfResidence: String,
                dateOfBirth: Double,
                digitalSignature: String
    ) {
        self.email = email
        self.firstname = firstname
        self.lastname = lastname
        self.phoneNumber = phoneNumber
        self.passportNumber = passportNumber
        self.passportFrom = passportFrom
        self.nationality = nationality
        self.placeOfResidence = placeOfResidence
        self.dateOfBirth = dateOfBirth
        self.digitalSignature = digitalSignature
    }

    public var parametersValue: Parameters {
        let parameters: [String: Any] = [
            RestApiConstants.email: email,
            RestApiConstants.firstname: firstname,
            RestApiConstants.lastname: lastname,
            RestApiConstants.phoneNumber: phoneNumber,
            RestApiConstants.passportNumber: passportNumber,
            RestApiConstants.passportFrom: passportFrom,
            RestApiConstants.nationality: nationality,
            RestApiConstants.placeOfResidence: placeOfResidence,
            RestApiConstants.dateOfBirth: dateOfBirth,
            RestApiConstants.digitalSignature: digitalSignature
            ]
        return parameters
    }
}
