//
//  ServicesGroupItemViewModel.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 16.11.2020.
//

public protocol ServicesGroupItemViewModelProtocol {
    var name: String { get set }
    var img: String { get set }
}

public final class ServicesGroupItemViewModel: ServicesGroupItemViewModelProtocol {
    public var name: String
    public var img: String

    public init(name: String, img: String) {
        self.name = name
        self.img = img
    }
}
