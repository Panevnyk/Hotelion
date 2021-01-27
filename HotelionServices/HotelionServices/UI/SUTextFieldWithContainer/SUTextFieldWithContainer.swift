//
//  SUTextFieldWithContainer.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 01.12.2020.
//

import UIKit
import HotelionCommon

final class SUTextFieldWithContainer: ContainerViewWithTitle {
    lazy var wrappedView = SUTextField(frame: bounds)

    override func initialize() {
        super.initialize()
        addViewToStack(wrappedView)
    }
}
