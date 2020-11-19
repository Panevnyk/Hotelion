//
//  File.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 27.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit

class BaseCustomView: UIView {
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        initialize()
    }

    func initialize() {}
}
