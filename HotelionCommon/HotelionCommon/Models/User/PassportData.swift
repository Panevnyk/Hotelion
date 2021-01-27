//
//  PassportData.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 22.01.2021.
//

import Foundation

public final class PassportData: Decodable {
    public var id: String
    public var number: String
    public var from: String
    public var nationality: String
    public var placeOfResidence: String
    public var dateOfBirth: Double

    // MARK: - Init
    public init(id: String,
                number: String,
                from: String,
                nationality: String,
                placeOfResidence: String,
                dateOfBirth: Double
    ) {
        self.id = id
        self.number = number
        self.from = from
        self.nationality = nationality
        self.placeOfResidence = placeOfResidence
        self.dateOfBirth = dateOfBirth
    }
}

// MARK: - KeychainService
extension PassportData {
    func saveDataToKeychainService() {
        KeychainService.save(key: RestApiConstants.passportDataId, value: id)
        KeychainService.save(key: RestApiConstants.number, value: number)
        KeychainService.save(key: RestApiConstants.from, value: from)
        KeychainService.save(key: RestApiConstants.nationality, value: nationality)
        KeychainService.save(key: RestApiConstants.placeOfResidence, value: placeOfResidence)
        KeychainService.save(key: RestApiConstants.dateOfBirth, value: String(dateOfBirth))
    }

    func readDataFromKeychainService() {
        id = KeychainService.load(key: RestApiConstants.passportDataId) ?? ""
        number = KeychainService.load(key: RestApiConstants.number) ?? ""
        from = KeychainService.load(key: RestApiConstants.from) ?? ""
        nationality = KeychainService.load(key: RestApiConstants.nationality) ?? ""
        placeOfResidence = KeychainService.load(key: RestApiConstants.placeOfResidence) ?? ""
        dateOfBirth = Double(KeychainService.load(key: RestApiConstants.dateOfBirth) ?? "") ?? 0
    }

    func removeDataFromKeychainService() {
        KeychainService.remove(key: RestApiConstants.passportDataId)
        KeychainService.remove(key: RestApiConstants.number)
        KeychainService.remove(key: RestApiConstants.from)
        KeychainService.remove(key: RestApiConstants.nationality)
        KeychainService.remove(key: RestApiConstants.placeOfResidence)
        KeychainService.remove(key: RestApiConstants.dateOfBirth)
    }
}
