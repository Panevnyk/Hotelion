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
    @IBOutlet private var emailTextField: SUTextField!
    @IBOutlet private var passwordTextField: SUPasswordTextField!
    @IBOutlet private var confirmPasswordTextField: SUTextField!
    @IBOutlet private var nameTextField: SUTextField!
    @IBOutlet private var phoneTextField: SUTextField!
    @IBOutlet private var nextStepButton: VioletButton!

    @IBOutlet private var separatorOneView: UIView!
    @IBOutlet private var separatorSecondView: UIView!
    @IBOutlet private var orLabel: UILabel!
    @IBOutlet private var alreadyHaveAccountLabel: UILabel!
    @IBOutlet private var receiveNewsletterLabel: UILabel!
    @IBOutlet private var privacyPolicyLabel: UILabel!

    @IBOutlet private var receiveNewsletterSwitch: UISwitch!
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

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - UIGestureRecognizerDelegate
extension RegistrationViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                  shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

// MARK: - Customize
private extension RegistrationViewController {
    func setupUI() {
        emailTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
        confirmPasswordTextField.placeholder = "Confirm password"
        nameTextField.placeholder = "Name"
        phoneTextField.placeholder = "Phone number optional"

        nameTextField.config = .name
        emailTextField.config = .email
        phoneTextField.config = .phoneNumber
        confirmPasswordTextField.config = .password

        nextStepButton.setTitle("Send", for: .normal)
        nextStepButton.isEnabled = true //false

        googleButton.layer.cornerRadius = 6
        googleButton.layer.borderWidth = 1
        googleButton.layer.borderColor = UIColor.kSeparatorGray.cgColor
        let googleImg = UIImage(named: "icGoogle", in: Bundle.auth, compatibleWith: nil)
        googleButton.setImage(googleImg, for: .normal)
        googleButton.setTitle(nil, for: .normal)

        facebookButton.layer.cornerRadius = 6
        facebookButton.backgroundColor = UIColor.kMidBlue
        let facebookImg = UIImage(named: "icFacebook", in: Bundle.auth, compatibleWith: nil)
        facebookButton.setImage(facebookImg, for: .normal)
        facebookButton.setTitle(nil, for: .normal)

        separatorOneView.backgroundColor = UIColor.kSeparatorGray
        separatorSecondView.backgroundColor = UIColor.kSeparatorGray

        receiveNewsletterSwitch.onTintColor = UIColor.kViolet
        receiveNewsletterSwitch.addTarget(self, action: #selector(receiveNewsLetterChangedAction), for: .valueChanged)

        orLabel.text = "or"
        orLabel.textColor = UIColor.kTextDarkGray
        orLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)

        alreadyHaveAccountLabel.text = "I already have an account"
        alreadyHaveAccountLabel.textColor = UIColor.kTextMiddleGray
        alreadyHaveAccountLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)

        receiveNewsletterLabel.text = "Receive newsletter"
        receiveNewsletterLabel.textColor = UIColor.kTextDarkGray
        receiveNewsletterLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)

        privacyPolicyLabel.text = "By sign in you agree to"
        privacyPolicyLabel.textColor = UIColor.kTextMiddleGray
        privacyPolicyLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)

        loginButton.setTitle("Login", for: .normal)
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
        emailTextField.textField.rx.text.map { $0 ?? "" }.bind(to: viewModel.emailText).disposed(by: disposeBag)

        passwordTextField.textField.rx.text.map { $0 ?? "" }.bind(to: viewModel.passwordText).disposed(by: disposeBag)

        confirmPasswordTextField.textField.rx.text.map { $0 ?? "" }.bind(to: viewModel.confirmPasswordText).disposed(by: disposeBag)

        nameTextField.textField.rx.text.map { $0 ?? "" }.bind(to: viewModel.nameText).disposed(by: disposeBag)

        phoneTextField.textField.rx.text.map { $0 ?? "" }.bind(to: viewModel.phoneNumberText).disposed(by: disposeBag)

        receiveNewsletterSwitch.rx.isOn.bind(to: viewModel.isReceiveNews).disposed(by: disposeBag)

        viewModel.isValid.bind(to: nextStepButton.rx.isEnabled).disposed(by: disposeBag)

        viewModel.emailValidationResult.bind(to: emailTextField.validationResultObservable).disposed(by: disposeBag)

        viewModel.passwordValidationResult.bind(to: passwordTextField.validationResultObservable).disposed(by: disposeBag)

        viewModel.confirmPasswordValidationResult.bind(to: confirmPasswordTextField.validationResultObservable).disposed(by: disposeBag)

        viewModel.nameValidationResult.bind(to: nameTextField.validationResultObservable).disposed(by: disposeBag)

        viewModel.phoneNumberValidationResult.bind(to: phoneTextField.validationResultObservable).disposed(by: disposeBag)

        passwordTextField.rightSecureButton.rx.tap.bind {
            self.confirmPasswordTextField.isSecureTextEntry = self.passwordTextField.isSecureTextEntry
        }.disposed(by: disposeBag)
    }

    func bindViewModel() {
        viewModel.isSuccessRegisterObservable.subscribe(onNext: { [unowned self] (value) in
            guard value else { return }
            self.coordinatorDelegate?.successRegistration()
        }).disposed(by: disposeBag)

        viewModel.successLoginedObservable
            .filter { $0 == true }
            .subscribe(onNext: { [unowned self] _ in
                self.coordinatorDelegate?.successLogin()
            }).disposed(by: disposeBag)

//        viewModel.successLoginedWithShowAddAccountsObservable
//            .filter { $0 == true }
//            .subscribe(onNext: { [unowned self] _ in
//                self.coordinatorDelegate?.showOnboardingScreen()
//            }).disposed(by: disposeBag)
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

    @IBAction func receiveNewsLetterChangedAction() {
        if !receiveNewsletterSwitch.isOn {}
    }
}

