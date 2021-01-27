//
//  TabBarItem.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 25.11.2020.
//

import UIKit

public enum MainTab: Int {
    case home
    case orders

    public var image: UIImage? {
        switch self {
        case .home:
            return UIImage(named: "icHome", in: Bundle.common, compatibleWith: nil)
        case .orders:
            return UIImage(named: "icOrders", in: Bundle.common, compatibleWith: nil)
        }
    }

    public var selectedImage: UIImage? {
        switch self {
        case .home:
            return UIImage(named: "icHomeSelected", in: Bundle.common, compatibleWith: nil)
        case .orders:
            return UIImage(named: "icOrdersSelected", in: Bundle.common, compatibleWith: nil)
        }
    }
}
