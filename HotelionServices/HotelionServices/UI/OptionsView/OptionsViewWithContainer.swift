//
//  OptionsViewWithContainer.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 18.11.2020.
//

import UIKit
import HotelionCommon

final class OptionsViewWithContainer: ContainerViewWithTitle {
    lazy var wrappedView = OptionsView(frame: bounds)

    override func initialize() {
        super.initialize()
        addViewToStack(wrappedView)
    }
}
