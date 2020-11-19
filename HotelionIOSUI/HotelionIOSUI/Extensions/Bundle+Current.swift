//
//  Bundle+Current.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 29.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation

extension Bundle {
    static var uiModuleBundle: Bundle {
        guard let bundle = Bundle(identifier: "vp.HotelionIOSUI") else {
            fatalError("!!! Problem with Bundle.uiModuleBundle identifier !!!")
        }
        return bundle
    }
}
