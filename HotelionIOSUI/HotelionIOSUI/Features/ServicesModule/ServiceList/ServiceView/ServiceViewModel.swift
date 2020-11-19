//
//  ServiceViewModel.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 14.08.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI

public final class ServiceViewModel: Identifiable, ObservableObject {
    public var id: Int
    public var title: String
    public var img: String

    @Published
    public var badgeTitle: String?

    public init(
        id: Int,
        title: String,
        img: String,
        badgeTitle: String? = nil
    ) {
        self.id = id
        self.title = title
        self.img = img
        self.badgeTitle = badgeTitle
    }
}
