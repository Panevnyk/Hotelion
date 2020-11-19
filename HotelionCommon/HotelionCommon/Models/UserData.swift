//
//  UserData.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 12.11.2020.
//

import Foundation

public final class UserData: Decodable {
    public var token: String
    public var user: User

    static var shared = UserData.empty

    // MARK: - Init
    public init(token: String, user: User) {
        self.token = token
        self.user = user
    }
}

// MARK: - Save
public extension UserData {
    static func save(userData: UserData) {
        shared = userData
        shared.saveDataToKeychainService()
    }
}

// MARK: - Empty
public extension UserData {
    static var empty: UserData {
        return UserData(token: "", user: User.empty)
    }
}

// MARK: - KeychainService
extension UserData {
    func saveDataToKeychainService() {
        KeychainService.save(key: RestApiConstants.token, value: token)
        user.saveDataToKeychainService()
    }

    func readDataFromKeychainService() {
        token = KeychainService.load(key: RestApiConstants.token) ?? ""
        user.readDataFromKeychainService()
    }

    func removeDataFromKeychainService() {
        KeychainService.remove(key: RestApiConstants.token)
        user.removeDataFromKeychainService()
    }
}
