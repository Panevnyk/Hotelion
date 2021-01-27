//
//  User.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 12.11.2020.
//

import Foundation

public final class User: Decodable {
    public var id: String = ""
    public var email: String = ""
    public var firstname: String = ""
    public var lastname: String = ""
    public var phoneNumber: String = ""

    public var passportData: PassportData?
    public var digitalSignature: String?

    public init(id: String,
                email: String,
                firstname: String,
                lastname: String,
                phoneNumber: String,
                passportData: PassportData?,
                digitalSignature: String?
    ) {
        self.id = id
        self.email = email
        self.firstname = firstname
        self.lastname = lastname
        self.phoneNumber = phoneNumber
        self.passportData = passportData
        self.digitalSignature = digitalSignature
    }
}

// MARK: - Personal info
public extension User {
    var isDigitalSignatureValid: Bool {
        guard let digitalSignature = digitalSignature else { return false }
        return digitalSignature.count > 0
    }
    
    var isPersonalInfoFull: Bool {
        return passportData != nil && isDigitalSignatureValid
    }
}

// MARK: - Empty
public extension User {
    static var empty: User {
        return User(
            id: "",
            email: "",
            firstname: "",
            lastname: "",
            phoneNumber: "",
            passportData: nil,
            digitalSignature: nil
        )
    }
}

// MARK: - KeychainService
extension User {
    func saveDataToKeychainService() {
        KeychainService.save(key: RestApiConstants.userId, value: id)
        KeychainService.save(key: RestApiConstants.email, value: email)
        KeychainService.save(key: RestApiConstants.firstname, value: firstname)
        KeychainService.save(key: RestApiConstants.lastname, value: lastname)
        KeychainService.save(key: RestApiConstants.phoneNumber, value: phoneNumber)

        passportData?.saveDataToKeychainService()
        KeychainService.save(key: RestApiConstants.digitalSignature, value: digitalSignature ?? "")
    }

    func readDataFromKeychainService() {
        id = KeychainService.load(key: RestApiConstants.userId) ?? ""
        email = KeychainService.load(key: RestApiConstants.email) ?? ""
        firstname = KeychainService.load(key: RestApiConstants.firstname) ?? ""
        lastname = KeychainService.load(key: RestApiConstants.lastname) ?? ""
        phoneNumber = KeychainService.load(key: RestApiConstants.phoneNumber) ?? ""

        passportData?.readDataFromKeychainService()
        digitalSignature = KeychainService.load(key: RestApiConstants.digitalSignature) ?? nil
    }

    func removeDataFromKeychainService() {
        KeychainService.remove(key: RestApiConstants.userId)
        KeychainService.remove(key: RestApiConstants.email)
        KeychainService.remove(key: RestApiConstants.firstname)
        KeychainService.remove(key: RestApiConstants.lastname)
        KeychainService.remove(key: RestApiConstants.phoneNumber)

        passportData?.readDataFromKeychainService()
        KeychainService.remove(key: RestApiConstants.digitalSignature)
    }
}
