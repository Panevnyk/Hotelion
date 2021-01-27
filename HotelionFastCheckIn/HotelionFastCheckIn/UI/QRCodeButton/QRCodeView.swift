//
//  QRCodeView.swift
//  HotelionFastCheckIn
//
//  Created by Vladyslav Panevnyk on 27.01.2021.
//

import UIKit
import RxSwift
import RxCocoa
import HotelionCommon

protocol QRCodeViewDelegate: class {
    func qrCodeDidTap()
}

final class QRCodeView: BaseCustomView {
    // MARK: - Properties
    // UI
    @IBOutlet private var xibView: UIView!
    @IBOutlet private var qrCodeButton: UIButton!
    @IBOutlet private var qrCodeScannedSuccessfuly: UILabel!
    @IBOutlet private var validationImageContainerView: UIView!
    @IBOutlet private var validationImageView: UIImageView!

    // Delegate
    weak var delegate: QRCodeViewDelegate?

    // Data
    let isValid = BehaviorRelay(value: false)
    private let disposeBag = DisposeBag()

    // MARK: - initialize
    override func initialize() {
        super.initialize()

        addSelfNibUsingConstraints(bundle: Bundle.fastCheckIn)
        bind()
        setupUI()
    }

    private func bind() {
        isValid
            .map { !$0 }
            .bind(to: validationImageContainerView.rx.isHidden)
            .disposed(by: disposeBag)

        isValid
            .map { !$0 }
            .bind(to: qrCodeScannedSuccessfuly.rx.isHidden)
            .disposed(by: disposeBag)
    }

    private func setupUI() {
        backgroundColor = .clear

        qrCodeButton.backgroundColor = .kInputBackgroundGrey
        qrCodeButton.layer.cornerRadius = 6
        qrCodeButton.layer.masksToBounds = true

        validationImageContainerView.backgroundColor = .kGreen
        validationImageContainerView.layer.cornerRadius = 11
        validationImageContainerView.layer.masksToBounds = true

        qrCodeScannedSuccessfuly.text = "Scanned successfully"
        qrCodeScannedSuccessfuly.textColor = .kGreen
        qrCodeScannedSuccessfuly.font = .kPlainText
    }
}

// MARK: - Actions
private extension QRCodeView {
    @IBAction func qrCodeButtonAction(_ sender: Any) {
        delegate?.qrCodeDidTap()
    }
}
