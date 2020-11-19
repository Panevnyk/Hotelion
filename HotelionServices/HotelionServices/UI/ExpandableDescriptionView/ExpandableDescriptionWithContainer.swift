//
//  ExpandableDescriptionWithContainer.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 18.11.2020.
//

import UIKit
import HotelionCommon

final class ExpandableDescriptionWithContainer: ContainerViewWithTitle {
    lazy var wrappedView = ExpandableDescriptionView(frame: bounds)

    override func initialize() {
        super.initialize()
        addViewToStack(wrappedView)
    }
}
