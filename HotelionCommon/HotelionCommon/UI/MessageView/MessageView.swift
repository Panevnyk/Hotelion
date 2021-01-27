//
//  MessageView.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 20.01.2021.
//

import UIKit

public final class MessageView: BaseCustomView {
    // MARK: - Properties
    @IBOutlet private var xibView: UIView!
    @IBOutlet private var messageLabel: UILabel!

    // MARK: - initialize
    public override func initialize() {
        super.initialize()

        addSelfNibUsingConstraints(bundle: Bundle.common)
        setupUI()
    }

    private func setupUI() {
        backgroundColor = .clear
        
        xibView.layer.cornerRadius = 6
        xibView.layer.masksToBounds = true
        xibView.backgroundColor = .kInputBackgroundGrey

        messageLabel.textColor = .kGrayText
        messageLabel.font = .kPlainText
    }

    public func setMessage(_ text: String) {
        messageLabel.text = text
    }
}
