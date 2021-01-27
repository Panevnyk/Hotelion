//
//  SUPasswordTextField.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 11.11.2020.
//

import UIKit

public protocol SUPasswordTextFieldDelegate: class {
    func didTapSecureButton(isSecureTextEntry: Bool)
}

public class SUPasswordTextField: SUTextField {
    /// UI
    public let rightSecureButton = UIButton(type: .custom)

    /// Delegate
    public weak var delegate: SUPasswordTextFieldDelegate?

    /// Initialize
    public override func initialize() {
        super.initialize()

        if #available(iOS 11.0, *) {
            textField.textContentType = UITextContentType.password
        }

        config = .password

        addRightArrow()
        minRightDistance = 39
        maxRightDistance = 78
    }

    private func addRightArrow() {
        /// change placeholder frame
        textFieldPadding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: minRightDistance)

        /// right arrow
        self.addSubview(rightSecureButton)
        self.addRightConstraint(view: rightSecureButton, top: 0, traling: -5, width: 44, height: 44)
        rightSecureButton.setImage(UIImage(named: "icEyeClose", in: Bundle.common, compatibleWith: nil), for: .normal)
        rightSecureButton.addTarget(self, action: #selector(tapSecureButton), for: .touchUpInside)

        checkBoxTralingCnstr?.constant = -54
        layoutIfNeeded()
    }

    /// API
    public func setSecureTextEntry(_ isSecureTextEntry: Bool) {
        self.isSecureTextEntry = isSecureTextEntry
        let eyeImgString = isSecureTextEntry ? "icEyeClose" : "icEyeOpen"
        let eyeImg = UIImage(named: eyeImgString, in: Bundle.auth, compatibleWith: nil)
        rightSecureButton.setImage(eyeImg, for: .normal)
    }

    public override var textInputContextIdentifier: String? {
        return "com.hotelionUpTeam.hotelion.passwordTextInputContextIdentifier"
    }
}

// MARK: - Actions
private extension SUPasswordTextField {
    @objc func tapSecureButton() {
        setSecureTextEntry(!isSecureTextEntry)
        delegate?.didTapSecureButton(isSecureTextEntry: isSecureTextEntry)
    }
}
