//
//  Bundle+HotelionCommon.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 11.11.2020.
//

import Foundation

public extension Bundle {
    static var common: Bundle {
        guard let bundle = Bundle(identifier: "vp.HotelionCommon") else {
            fatalError("!!! Problem with Bundle.common identifier !!!")
        }
        return bundle
    }

    static var auth: Bundle {
        guard let bundle = Bundle(identifier: "vp.HotelionAuth") else {
            fatalError("!!! Problem with Bundle.auth identifier !!!")
        }
        return bundle
    }

    static var fastCheckIn: Bundle {
        guard let bundle = Bundle(identifier: "vp.HotelionFastCheckIn") else {
            fatalError("!!! Problem with Bundle.fastCheckIn identifier !!!")
        }
        return bundle
    }

    static var services: Bundle {
        guard let bundle = Bundle(identifier: "vp.HotelionServices") else {
            fatalError("!!! Problem with Bundle.services identifier !!!")
        }
        return bundle
    }

    static var orders: Bundle {
        guard let bundle = Bundle(identifier: "vp.HotelionOrders") else {
            fatalError("!!! Problem with Bundle.orders identifier !!!")
        }
        return bundle
    }

    static var profile: Bundle {
        guard let bundle = Bundle(identifier: "vp.HotelionProfile") else {
            fatalError("!!! Problem with Bundle.orders identifier !!!")
        }
        return bundle
    }
}
