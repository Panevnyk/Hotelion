//
//  DigitalSignatureView.swift
//  HotelionFastCheckIn
//
//  Created by Vladyslav Panevnyk on 13.01.2021.
//

import UIKit
import RxSwift
import RxCocoa
import HotelionCommon

protocol DigitalSignatureViewDelegate: class {
    func editDigitalSignature(from view: DigitalSignatureView, signatureImage: UIImage?)
    func removeDigitalSignatureAction(from view: DigitalSignatureView)
}

final class DigitalSignatureView: BaseCustomView {
    // MARK: - Properties
    @IBOutlet private var xibView: UIView!
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var signatureImageView: UIImageView!
    @IBOutlet private var actionButton: UIButton!
    @IBOutlet private var editButton: UIButton!
    @IBOutlet private var closeButton: UIButton!
    @IBOutlet private var addedSuccessfullyLabel: UILabel!

    var digitalSignatureStatus = BehaviorRelay<DigitalSignatureStatus>(value: .empty)
    private let disposeBag = DisposeBag()

    // Delegate
    weak var delegate: DigitalSignatureViewDelegate?

    // MARK: - initialize
    override func initialize() {
        super.initialize()

        addSelfNibUsingConstraints(bundle: Bundle.fastCheckIn)
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        layer.cornerRadius = 6
        layer.masksToBounds = true
        backgroundColor = UIColor.kInputBackgroundGrey

        actionButton.layer.cornerRadius = 20
        actionButton.layer.masksToBounds = true

        addedSuccessfullyLabel.text = "Added successfuly"
        addedSuccessfullyLabel.textColor = .kGreen
        addedSuccessfullyLabel.font = .kPlainText
    }

    private func bindViewModel() {
        digitalSignatureStatus
            .subscribe { (digitalSignatureStatus) in
                self.setStatus(digitalSignatureStatus)
            }
            .disposed(by: disposeBag)
    }
    
    private func setStatus(_ status: DigitalSignatureStatus) {
        let isEmpty = status.isEmpty
        let signatureImage = status.signatureImage

        signatureImageView.image = signatureImage
        closeButton.isHidden = isEmpty
        editButton.isHidden = isEmpty
        actionButton.isHidden = !isEmpty
        actionButton.backgroundColor = .kViolet
        addedSuccessfullyLabel.isHidden = isEmpty
    }
}

// MARK: - Actions
private extension DigitalSignatureView {
    @IBAction func addDigitalSignatureAction(_ sender: Any) {
        delegate?.editDigitalSignature(from: self, signatureImage: digitalSignatureStatus.value.signatureImage)
    }

    @IBAction func editAction(_ sender: Any) {
        delegate?.editDigitalSignature(from: self, signatureImage: digitalSignatureStatus.value.signatureImage)
    }

    @IBAction func closeAction(_ sender: Any) {
        delegate?.removeDigitalSignatureAction(from: self)
    }
}

public enum DigitalSignatureStatus {
    case empty
    case signatured(signature: String)

    public var isEmpty: Bool {
        switch self {
        case .empty: return true
        case .signatured: return false
        }
    }

    public var signature: String {
        switch self {
        case .empty: return ""
        case .signatured(let signature): return signature
        }
    }

    public var signatureImage: UIImage? {
        switch self {
        case .empty: return nil
        case .signatured(let signature): return signature.fromBase64ToUIImage()
        }
    }

    public static func makeFrom(_ signature: String) -> DigitalSignatureStatus {
        if signature.count > 0 {
            return .signatured(signature: signature)
        } else {
            return .empty
        }
    }
}
