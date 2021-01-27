//
//  DigitalSignatureViewController.swift
//  HotelionFastCheckIn
//
//  Created by Vladyslav Panevnyk on 14.01.2021.
//

import UIKit
import SwiftSignatureView
import RxSwift
import RxCocoa
import HotelionCommon

public protocol DigitalSignatureCoordinatorDelegate: class {
    func didAddDigitalSignature(signature: String, from viewController: DigitalSignatureViewController)
    func dismiss(from viewController: DigitalSignatureViewController)
}

public final class DigitalSignatureViewController: UIViewController {
    // MARK: - Properties
    // UI
    @IBOutlet private var signatureView: SwiftSignatureView!
    @IBOutlet private var cleanButton: UIButton!
    @IBOutlet private var closeButton: UIButton!
    @IBOutlet private var addSignatureButton: VioletButton!

    // Img
    public var signatureImage: UIImage?

    // ViewModel
    public var viewModel: DigitalSignatureViewModelProtocol!
    private let disposeBag = DisposeBag()

    // Delegates
    public weak var coordinatorDelegate: DigitalSignatureCoordinatorDelegate?

    // MARK: - Life cycle
    override public func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViewModels()
    }
    
    private func setupUI() {
        signatureView.signature = signatureImage
        signatureView.maximumStrokeWidth = 8
        signatureView.minimumStrokeWidth = 8
        signatureView.delegate = self

        cleanButton.layer.cornerRadius = 20
        cleanButton.layer.masksToBounds = true
        cleanButton.backgroundColor = .kViolet

        closeButton.layer.cornerRadius = 20
        closeButton.layer.masksToBounds = true
        closeButton.backgroundColor = .white

        addSignatureButton.setTitle("Add signature", for: .normal)
    }
}

// MARK: - ViewModels
private extension DigitalSignatureViewController {
    func setupViewModels() {
        bindUI()
    }

    func bindUI() {
        viewModel.isValid
            .bind(to: addSignatureButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}

// MARK: - Actions
private extension DigitalSignatureViewController {
    @IBAction func cleanAction(_ sender: Any) {
        signatureView.clear()
        viewModel.isSignatureDraw.accept(false)
    }

    @IBAction func closeAction(_ sender: Any) {
        coordinatorDelegate?.dismiss(from: self)
    }

    @IBAction func addSignatureAction(_ sender: Any) {
        guard let signatureImage = signatureView.signature else {
            print("!!! FAIL: Signature image is nil !!!")
            return
        }
        self.signatureImage = signatureImage
        let signature = viewModel.makeSignature(from: signatureImage)
        coordinatorDelegate?.didAddDigitalSignature(signature: signature, from: self)
    }
}

// MARK: - SwiftSignatureViewDelegate
extension DigitalSignatureViewController: SwiftSignatureViewDelegate {
    public func swiftSignatureViewDidDraw(_ view: ISignatureView) {
        viewModel.isSignatureDraw.accept(true)
    }

    public func swiftSignatureViewDidDrawGesture(_ view: ISignatureView, _ tap: UIGestureRecognizer) {}
}
