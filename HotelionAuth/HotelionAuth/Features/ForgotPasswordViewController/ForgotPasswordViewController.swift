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
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    /// change status bar
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

// MARK: - UIGestureRecognizerDelegate
extension ForgotPasswordViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                  shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

// MARK: - UI
private extension ForgotPasswordViewController {
    func setupUI() {
        title = "Forgot password"
        hintLabel.text = "Reset password text"
        emailTextField.placeholder = "Email"
        emailTextField.config = .email
        sendButton.setTitle("Send", for: .normal)

        navigationItem.leftBarButtonItem = NavigationItemFactory.createBackItem(viewController: self,
                                                                                selector: #selector(backAction))

        hintLabel.textColor = UIColor.kTextDarkGray
        hintLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)

//        navigationController?.navigationBar.customizeWhite()
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
        viewModel.isSuccessSendObservable.subscribe(onNext: { [unowned self] (value) in
            guard value else {
                return
            }

            let email = self.viewModel.emailText.value
//            AlertHelper.show(message: Localize("temporary_password_was_sent"), okAction: { (_) in
//                self.forgotPasswordCoordinatorDelegate?.didSelectLoginWith(email: email)
//            })
        }).disposed(by: disposeBag)
    }
}

// MARK: - Actions
private extension ForgotPasswordViewController {
    @objc func backAction() {
        coordinatorDelegate?.dissmiss()
    }

    @IBAction func sendAction() {
        viewModel.sendActions()
    }
}
