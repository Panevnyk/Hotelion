//
//  ForgotPasswordViewController.swift
//  SaleUp
//
//  Created by sxsasha on 27.02.18.
//  Copyright © 2018 Devlight. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RestApiManager
import HotelionCommon

public protocol ForgotPasswordCoordinatorDelegate: class {
    func didSelectLoginWith(email: String)
    func dissmiss()
}

public final class ForgotPasswordViewController: BaseScrollViewController {
    // MARK: - Properties
    // UI
    @IBOutlet private var headerView: HeaderView!

    @IBOutlet private var hintLabel: UILabel!
    @IBOutlet private var emailTextField: SUTextField!
    @IBOutlet private var sendButton: VioletButton!

    // Coordinator delegate
    public weak var coordinatorDelegate: ForgotPasswordCoordinatorDelegate?

    // ViewModels
    public var viewModel: ForgotPasswordViewModelProtocol!
    private let disposeBag = DisposeBag()

    // Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViewModels()
    }
}

// MARK: - UI
private extension ForgotPasswordViewController {
    func setupUI() {
        headerView.setTitle("Forgot password")
        headerView.isBackButtonHidden = false
        headerView.delegate = self

        hintLabel.text = "We will send password to your email"
        hintLabel.textColor = UIColor.kTextMiddleGray
        hintLabel.font = UIFont.kPlainText

        emailTextField.placeholder = "Email"
        emailTextField.config = .email

        sendButton.setTitle("Send", for: .normal)

        hintLabel.textColor = UIColor.kTextDarkGray
        hintLabel.font = UIFont.kPlainText
    }
}

// MARK: - ViewModels
private extension ForgotPasswordViewController {
    func setupViewModels() {
        bindUI()
        bindViewModel()
    }

    func bindUI() {
        emailTextField.textField.rx.text.map { $0 ?? "" }.bind(to: viewModel.emailText).disposed(by: disposeBag)

        viewModel.isValid.bind(to: sendButton.rx.isEnabled).disposed(by: disposeBag)

        viewModel.emailValidationResult.bind(to: emailTextField.validationResultObservable).disposed(by: disposeBag)
    }

    func bindViewModel() {
//        viewModel.isSuccessSendObservable.subscribe(onNext: { [unowned self] (value) in
//            guard value else {
//                return
//            }

//            let email = self.viewModel.emailText.value
//            AlertHelper.show(message: Localize("temporary_password_was_sent"), okAction: { (_) in
//                self.forgotPasswordCoordinatorDelegate?.didSelectLoginWith(email: email)
//            })
//        }).disposed(by: disposeBag)
    }
}

// MARK: - HeaderViewDelegate
extension ForgotPasswordViewController: HeaderViewDelegate {
    public func backAction(from view: HeaderView) {
        coordinatorDelegate?.dissmiss()
    }
}

// MARK: - Actions
private extension ForgotPasswordViewController {
    @IBAction func sendAction() {
        viewModel.sendActions()
    }
}
