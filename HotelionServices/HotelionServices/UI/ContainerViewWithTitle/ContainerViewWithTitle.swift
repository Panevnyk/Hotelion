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

    public func setText(_ text: String, description: String) {
        titleLabel.attributedText = makeAttributedText(text: text, description: description)
    }

    public func addViewToStack(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }

    // MARK: - Helpers
    private func makeAttributedText(text: String, description: String) -> NSAttributedString {
        let sentence = text + " " + description
        let textAttributes = [NSAttributedString.Key.font: UIFont.kSectionHeaderText,
                               NSAttributedString.Key.foregroundColor: UIColor.black]
        let descriptionAttributes = [NSAttributedString.Key.font: UIFont.kPlainText,
                                  NSAttributedString.Key.foregroundColor: UIColor.black]
        let attributedSentence = NSMutableAttributedString(string: sentence, attributes: textAttributes)

        let range = NSRange(location: text.count + 1,
                            length: description.count)
        attributedSentence.setAttributes(descriptionAttributes, range: range)

        return attributedSentence
    }
}
