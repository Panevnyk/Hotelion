//
//  HeaderView.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 20.01.2021.
//

import UIKit

public protocol HeaderViewDelegate: class {
    func backAction(from view: HeaderView)
}

final public class HeaderView: BaseCustomView {
    // MARK: - Properties
    // UI
    @IBOutlet private var xibView: UIView!
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var backgroundImageView: UIImageView!
    @IBOutlet private var actionStackView: UIStackView!
    @IBOutlet private var backButton: UIButton!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var logoImageView: UIImageView!

    public var isBackButtonHidden: Bool = true {
        didSet {
            backButton.isHidden = isBackButtonHidden
        }
    }

    // Delegate
    public weak var delegate: HeaderViewDelegate?

    // MARK: - initialize
    override public func initialize() {
        super.initialize()

        addSelfNibUsingConstraints(bundle: Bundle.common)
        setupUI()
    }

    public func setTitle(_ text: String) {
        titleLabel.text = text
    }

    private func setupUI() {
        isBackButtonHidden = true

        clipsToBounds = true

        backButton.layer.cornerRadius = 16
        backButton.layer.masksToBounds = true
        backButton.backgroundColor = .kViolet

        titleLabel.font = UIFont.kBigTitleText
        titleLabel.textColor = .white
    }
}

// MARK: - Actions
private extension HeaderView {
    @IBAction func backAction(_ sender: Any) {
        delegate?.backAction(from: self)
    }
}
