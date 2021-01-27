//
//  ProfileCollectionViewModel.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 30.11.2020.
//

public protocol ProfileCollectionViewModelProtocol {
    var name: String { get }
    var livingDetails: String { get }
    var avatar: String { get }
}

public final class ProfileCollectionViewModel: ProfileCollectionViewModelProtocol {
    public let name: String
    public let livingDetails: String
    public let avatar: String

    public init(name: String,
                livingDetails: String,
                avatar: String) {
        self.name = name
        self.livingDetails = livingDetails
        self.avatar = avatar
    }
}
