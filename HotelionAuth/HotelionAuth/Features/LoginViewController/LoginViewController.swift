//
//  LoginViewController.swift
//  SaleUp
//
//  Created by Panevnyk Vlad on 2/22/18.
//  Copyright © 2018 Devlight. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import HotelionCommon
import RestApiManager

public protocol BaseAuthCoordinatorDelegate: class {
    func didSelectLogin()
    func didSelectSignUp()

    func successLogin()
    func didSelectPrivacyPolicy()
}

public protocol LoginViewControllerCoordinatorDelegate: BaseAuthCoordinatorDelegate {
    func successLoginWithoutCode(email: String, password: String)
    func didSelectForgotPassword()
}

public final class LoginViewController: BaseScrollViewController {
    // MARK: - Properties
    // UI
    @IBOutlet private var headerView: HeaderView!

    @IBOutlet private var emailTextField: SUTextField!
    @IBOutlet private var passwordTextField: SUPasswordTextField!
    @IBOutlet private var loginButton: VioletButton!

    @IBOutlet private var separatorOneView: UIView!
    @IBOutlet private var separatorSecondView: UIView!
    @IBOutlet private var orLabel: UILabel!
    @IBOutlet private var dontHaveAccountLabel: UILabel!
    @IBOutlet private var privacyPolicyLabel: UILabel!

    @IBOutlet private var forgotPasswordButton: UIButton!
    @IBOutlet private var privacyPolicyButton: UIButton!
    @IBOutlet private var signUpButton: UIButton!

    @IBOutlet private var googleButton: UIButton!
    @IBOutlet private var facebookButton: UIButton!

    // Coordinator delegate
    public weak var coordinatorDelegate: LoginViewControllerCoordinatorDelegate?

    // ViewModels
    public var viewModel: LoginViewModelProtocol!
    private let disposeBag = DisposeBag()

    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViewModels()

        // get default email if contains
        if let defaultEmail = viewModel.getDefaultEmail() {
            emailTextField.text = defaultEmail
        }
    }
}

// MARK: - ViewModels
private extension LoginViewController {
    func setupViewModels() {
        bindUI()
        bindViewModel()
    }

    func bindUI() {
        emailTextField.textField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.emailText)
            .disposed(by: disposeBag)

        passwordTextField.textField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.passwordText)
            .disposed(by: disposeBag)

        viewModel.isValid
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)

        viewModel.emailValidationResult
            .bind(to: emailTextField.validationResultObservable)
            .disposed(by: disposeBag)

        viewModel.passwordValidationResult
            .bind(to: passwordTextField.validationResultObservable)
            .disposed(by: disposeBag)
    }

    func bindViewModel() {
        viewModel.successLoginedObservable
            .filter { $0 == true }
            .subscribe(onNext: { [unowned self] _ in
                self.coordinatorDelegate?.successLogin()
            }).disposed(by: disposeBag)

//        viewModel.successLoginedWithShowAddAccountsObservable
//            .filter { $0 == true }
//            .subscribe(onNext: { [unowned self] _ in
//                self.coordinatorDelegate?.shouldOpenAddEbayAccountVC()
//            }).disposed(by: disposeBag)

//        viewModel.isAccountNotConfirmObservable.subscribe(onNext: { [unowned self] (value) in
//            if value {
//                let email = self.viewModel.emailText.value
//                let password = self.viewModel.passwordText.value
//                self.coordinatorDelegate?.successLoginWithoutCode(email: email,
//                                                                  password: password)
//            }
//        }).disposed(by: disposeBag)
    }
}

// MARK: - Customize
private extension LoginViewController {
    func setupUI() {
        // FIXME: - hardcode email & password
        emailTextField.text = "test@test.com"
        passwordTextField.text = "12341234"

        emailTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"

        loginButton.setTitle("Sign in", for: .normal)
        loginButton.isEnabled = true

        emailTextField.config = .email

        googleButton.layer.cornerRadius = 6
        googleButton.layer.borderWidth = 1
        googleButton.layer.borderColor = UIColor.lightGray.cgColor
        let googleImg = UIImage(named: "icGoogle", in: Bundle.auth, compatibleWith: nil)
        googleButton.setImage(googleImg, for: .normal)
        googleButton.setTitle(nil, for: .normal)

        facebookButton.layer.cornerRadius = 6
        facebookButton.backgroundColor = UIColor.kFacebook
        let facebookImg = UIImage(named: "icFacebook", in: Bundle.auth, compatibleWith: nil)
        facebookButton.setImage(facebookImg, for: .normal)
        facebookButton.setTitle(nil, for: .normal)

        headerView.setTitle("Login")

        separatorOneView.backgroundColor = UIColor.kSeparatorGray
        separatorSecondView.backgroundColor = UIColor.kSeparatorGray

        orLabel.text = "or"
        orLabel.textColor = UIColor.kTextDarkGray
        orLabel.font = UIFont.kTitleText

        privacyPolicyLabel.text = "By sign in you agree to"
        privacyPolicyLabel.textColor = UIColor.kTextMiddleGray
        privacyPolicyLabel.font = UIFont.kPlainText

        dontHaveAccountLabel.text = "I dont have an account"
        dontHaveAccountLabel.textColor = UIColor.kTextMiddleGray
        dontHaveAccountLabel.font = UIFont.kPlainText

        forgotPasswordButton.setTitle("Forgot password", for: .normal)
        forgotPasswordButton.setTitleColor(UIColor.kViolet, for: .normal)

        privacyPolicyButton.setTitle("Privacy policy", for: .normal)
        privacyPolicyButton.setTitleColor(UIColor.kViolet, for: .normal)

        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.setTitleColor(UIColor.kViolet, for: .normal)
    }
}

// MARK: - Actions
private extension LoginViewController {
    @IBAction func forgotPasswordAction() {
        coordinatorDelegate?.didSelectForgotPassword()
    }

    @IBAction func privacyPolicyAction() {
        coordinatorDelegate?.didSelectPrivacyPolicy()
    }

    @IBAction func loginAction() {
        viewModel.loginActions()
    }

    @IBAction func googleAuthAction() {
//        loginViewModel.login(by: .google)
    }

    @IBAction func facebookAuthAction() {
//        loginViewModel.login(by: .facebook)
    }

    @IBAction func signUpAction() {
        coordinatorDelegate?.didSelectSignUp()
    }
}
