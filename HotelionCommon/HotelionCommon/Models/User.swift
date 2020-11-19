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

    public init(id: String, email: String) {
        self.id = id
        self.email = email
    }
}

// MARK: - Empty
public extension User {
    static var empty: User {
        return User(id: "", email: "")
    }
}

// MARK: - KeychainService
extension User {
    func saveDataToKeychainService() {
        KeychainService.save(key: RestApiConstants.userId, value: id)
        KeychainService.save(key: RestApiConstants.email, value: email)
    }

    func readDataFromKeychainService() {
        id = KeychainService.load(key: RestApiConstants.userId) ?? ""
        email = KeychainService.load(key: RestApiConstants.email) ?? ""
    }

    func removeDataFromKeychainService() {
        KeychainService.remove(key: RestApiConstants.userId)
        KeychainService.remove(key: RestApiConstants.email)
    }
}
