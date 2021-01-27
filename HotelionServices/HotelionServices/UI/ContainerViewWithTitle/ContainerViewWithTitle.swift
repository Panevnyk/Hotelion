//
//  ContainerViewWithTitle.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 18.11.2020.
//

import UIKit

open class ContainerViewWithTitle: BaseCustomView {
    // MARK: - Properties
    @IBOutlet public var xibView: UIView!
    @IBOutlet public var stackView: UIStackView!
    @IBOutlet public var titleLabel: UILabel!

    // MARK: - initialize
    open override func initialize() {
        addSelfNibUsingConstraints(nibName: "ContainerViewWithTitle", bundle: Bundle.common)

        titleLabel.font = UIFont.kSectionHeaderText
    }

    // MARK: - Public methods
    public func setText(_ text: String) {
        titleLabel.text = text
    }

    public func addViewToStack(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }
}
