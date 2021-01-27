//
//  RegistrationViewController.swift
//  SaleUp
//
//  Created by sxsasha on 02.03.18.
//  Copyright © 2018 Devlight. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RestApiManager
import HotelionCommon

public protocol RegistrationViewControllerCoordinatorDelegate: BaseAuthCoordinatorDelegate {
    func successRegistration()
}

public final class RegistrationViewController: BaseScrollViewController {
    // MARK: - Properties
    // UI
    @IBOutlet private var headerView: HeaderView!

    @IBOutlet private var firstnameTextField: SUTextField!
    @IBOutlet private var lastnameTextField: SUTextField!
    @IBOutlet private var emailTextField: SUTextField!
    @IBOutlet private var phoneTextField: SUTextField!
    @IBOutlet private var passwordTextField: SUPasswordTextField!

    @IBOutlet private var nextStepButton: VioletButton!

    @IBOutlet private var separatorOneView: UIView!
    @IBOutlet private var separatorSecondView: UIView!
    @IBOutlet private var orLabel: UILabel!
    @IBOutlet private var alreadyHaveAccountLabel: UILabel!
    @IBOutlet private var privacyPolicyLabel: UILabel!

    @IBOutlet private var loginButton: UIButton!

    @IBOutlet private var privacyPolicyButton: UIButton!
    @IBOutlet private var googleButton: UIButton!
    @IBOutlet private var facebookButton: UIButton!

    // Coordinator delegate
    public weak var coordinatorDelegate: RegistrationViewControllerCoordinatorDelegate?

    // ViewModels
    public var viewModel: RegisterViewModelProtocol!
    private let disposeBag = DisposeBag()

    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViewModels()
    }
}

// MARK: - Customize
private extension RegistrationViewController {
    func setupUI() {
        // FIXME: - hardcode email & password
        firstnameTextField.text = "Jon"
        lastnameTextField.text = "Snow"
        emailTextField.text = "test@test.com"
        phoneTextField.text = "1234556789"
        passwordTextField.text = "12341234"

        firstnameTextField.placeholder = "First name"
        lastnameTextField.placeholder = "Last name"
        emailTextField.placeholder = "Email"
        phoneTextField.placeholder = "Phone number"
        passwordTextField.placeholder = "Password"

        firstnameTextField.config = .name
        firstnameTextField.config = .name
        emailTextField.config = .email
        phoneTextField.config = .phoneNumber

        nextStepButton.setTitle("Sign up", for: .normal)
        nextStepButton.isEnabled = true //false

        googleButton.layer.cornerRadius = 6
        googleButton.layer.borderWidth = 1
        googleButton.layer.borderColor = UIColor.kSeparatorGray.cgColor
        let googleImg = UIImage(named: "icGoogle", in: Bundle.auth, compatibleWith: nil)
        googleButton.setImage(googleImg, for: .normal)
        googleButton.setTitle(nil, for: .normal)

        facebookButton.layer.cornerRadius = 6
        facebookButton.backgroundColor = UIColor.kFacebook
        let facebookImg = UIImage(named: "icFacebook", in: Bundle.auth, compatibleWith: nil)
        facebookButton.setImage(facebookImg, for: .normal)
        facebookButton.setTitle(nil, for: .normal)

        headerView.setTitle("Registration")
    
        separatorOneView.backgroundColor = UIColor.kSeparatorGray
        separatorSecondView.backgroundColor = UIColor.kSeparatorGray

        orLabel.text = "or"
        orLabel.textColor = UIColor.kTextDarkGray
        orLabel.font = UIFont.kTitleText

        alreadyHaveAccountLabel.text = "I already have an account"
        alreadyHaveAccountLabel.textColor = UIColor.kTextMiddleGray
        alreadyHaveAccountLabel.font = UIFont.kPlainText

        privacyPolicyLabel.text = "By sign up you agree to"
        privacyPolicyLabel.textColor = UIColor.kTextMiddleGray
        privacyPolicyLabel.font = UIFont.kPlainText

        loginButton.setTitle("Sign in", for: .normal)
        loginButton.setTitleColor(UIColor.kViolet, for: .normal)

        privacyPolicyButton.setTitle("Privacy policy", for: .normal)
        privacyPolicyButton.setTitleColor(UIColor.kViolet, for: .normal)
    }
}

// MARK: - ViewModels
private extension RegistrationViewController {
    func setupViewModels() {
        bindUI()
        bindViewModel()
    }

    func bindUI() {
        firstnameTextField.textField.rx.text.map { $0 ?? "" }.bind(to: viewModel.firstnameText).disposed(by: disposeBag)

        lastnameTextField.textField.rx.text.map { $0 ?? "" }.bind(to: viewModel.lastnameText).disposed(by: disposeBag)

        emailTextField.textField.rx.text.map { $0 ?? "" }.bind(to: viewModel.emailText).disposed(by: disposeBag)

        phoneTextField.textField.rx.text.map { $0 ?? "" }.bind(to: viewModel.phoneNumberText).disposed(by: disposeBag)

        passwordTextField.textField.rx.text.map { $0 ?? "" }.bind(to: viewModel.passwordText).disposed(by: disposeBag)
    }

    func bindViewModel() {
        // personal data
        viewModel.firstnameValidationResult.bind(to: firstnameTextField.validationResultObservable).disposed(by: disposeBag)

        viewModel.lastnameValidationResult.bind(to: lastnameTextField.validationResultObservable).disposed(by: disposeBag)

        viewModel.emailValidationResult.bind(to: emailTextField.validationResultObservable).disposed(by: disposeBag)

        viewModel.phoneNumberValidationResult.bind(to: phoneTextField.validationResultObservable).disposed(by: disposeBag)

        viewModel.passwordValidationResult.bind(to: passwordTextField.validationResultObservable).disposed(by: disposeBag)

        // isValid
        viewModel.isValid.bind(to: nextStepButton.rx.isEnabled).disposed(by: disposeBag)

        // isSuccess
        viewModel.isSuccessRegisterObservable.subscribe(onNext: { [unowned self] (value) in
            guard value else { return }
            self.coordinatorDelegate?.successRegistration()
        }).disposed(by: disposeBag)

        viewModel.successLoginedObservable
            .filter { $0 == true }
            .subscribe(onNext: { [unowned self] _ in
                self.coordinatorDelegate?.successLogin()
            }).disposed(by: disposeBag)
    }
}

// MARK: - Actions
private extension RegistrationViewController {
    @IBAction func privacyPolicyAction() {
        coordinatorDelegate?.didSelectPrivacyPolicy()
    }

    @IBAction func nextStepAction() {
        viewModel.registerAction()
    }

    @IBAction func googleAuthAction() {
//        registerViewModel.login(by: .google)
    }

    @IBAction func facebookAuthAction() {
//        registerViewModel.login(by: .facebook)
    }

    @IBAction func loginAction() {
        coordinatorDelegate?.didSelectLogin()
    }
}

