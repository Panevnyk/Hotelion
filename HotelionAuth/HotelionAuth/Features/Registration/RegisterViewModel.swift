//
//  RegistrationViewModel.swift
//  SaleUp
//
//  Created by sxsasha on 15.03.18.
//  Copyright © 2018 Devlight. All rights reserved.
//

import RestApiManager
import RxSwift
import RxCocoa
import RestApiManager
import HotelionCommon

public protocol RegisterViewModelProtocol {
    // To View
    var isSuccessRegisterObservable: Observable<Bool> { get }
    var successLoginedObservable: Observable<Bool> { get }
//    var successLoginedWithShowAddAccountsObservable: Observable<Bool> { get }

    // From View
    var emailText: BehaviorRelay<String> { get }
    var passwordText: BehaviorRelay<String> { get }
    var confirmPasswordText: BehaviorRelay<String> { get }
    var nameText: BehaviorRelay<String> { get }
    var phoneNumberText: BehaviorRelay<String> { get }
    var isReceiveNews: BehaviorRelay<Bool> { get }

    // Observables
    var emailValidationResult: Observable<ValidationResult> { get }
    var passwordValidationResult: Observable<ValidationResult> { get }
    var confirmPasswordValidationResult: Observable<ValidationResult> { get }
    var nameValidationResult: Observable<ValidationResult> { get }
    var phoneNumberValidationResult: Observable<ValidationResult> { get }
    var isValid: Observable<Bool> { get }

    // Actions
    func registerAction()
//    func login(by network: SocialNetwork)
}

public final class RegisterViewModel: LoginUsingSocialNetwork, RegisterViewModelProtocol {
    // MARK: - Properties
    // Boundaries
    private let restApiManager: RestApiManager
    
    // Variables
    private var isSuccessRegister = BehaviorRelay<Bool>(value: false)

    // Validators
    private var emailValidator: ValidatorProtocol = EmailValidator()
    private var passwordValidator: ValidatorProtocol = PasswordValidator()
    private var fullNameValidator: ValidatorProtocol = FullnameValidator()
    private var phoneNumberValidator: ValidatorProtocol = PhoneNumberValidator()

    // From View
    public var emailText = BehaviorRelay<String>(value: "")
    public var passwordText = BehaviorRelay<String>(value: "")
    public var confirmPasswordText = BehaviorRelay<String>(value: "")
    public var nameText = BehaviorRelay<String>(value: "")
    public var phoneNumberText = BehaviorRelay<String>(value: "")
    public var isReceiveNews = BehaviorRelay<Bool>(value: false)

    // Observables
    public lazy var isSuccessRegisterObservable = isSuccessRegister.asObservable()

    public var emailValidationResult: Observable<ValidationResult> {
        return emailText.asObservable().map({ (email) -> ValidationResult in
            return self.emailValidator.validate(email)
        })
    }

    public var passwordValidationResult: Observable<ValidationResult> {
        return passwordText.asObservable().map({ (password) -> ValidationResult in
            return self.passwordValidator.validate(password)
        })
    }

    public var confirmPasswordValidationResult: Observable<ValidationResult> {
        return Observable.combineLatest(confirmPasswordText.asObservable(), passwordValidationResult) { [unowned self] (value, passwordValidationResult) ->  ValidationResult in
            return value.isEmpty
                ? .noResult
                : (value == self.passwordText.value
                    ? .success
                    : .error("Passwords do not match"))
        }
    }

    public var nameValidationResult: Observable<ValidationResult> {
        return nameText.asObservable().map({ [unowned self] (name) -> ValidationResult in
            return self.fullNameValidator.validate(name)
        })
    }

    public var phoneNumberValidationResult: Observable<ValidationResult> {
        return phoneNumberText.asObservable().map({ [unowned self] (value) -> ValidationResult in
            return self.phoneNumberValidator.validate(value)
        })
    }

    public var isValid: Observable<Bool> {
        return Observable.combineLatest(emailValidationResult, passwordValidationResult, confirmPasswordValidationResult, nameValidationResult, phoneNumberValidationResult) { email, password, confirmPassword, name, phone in
            return email.isValid && password.isValid && confirmPassword.isValid && name.isValid
        }
    }

    // MARK: - Inits
    public init(restApiManager: RestApiManager) {
        self.restApiManager = restApiManager
    }
}

// MARK: - RestApiable
extension RegisterViewModel {
    public func registerAction() {
        let parameters = SignupParameters(email: emailText.value,
                                          password: passwordText.value/*,fullName: nameText.value*/)
        let method = AuthRestApiMethods.signup(parameters)

        ActivityIndicatorHelper.shared.show()
        restApiManager.call(method: method) { [weak self] (result: Result<UserData>) in
            DispatchQueue.main.async {
                ActivityIndicatorHelper.shared.hide()
                switch result {
                case .success(let userData):
                    UserData.save(userData: userData)
                    self?.isSuccessRegister.accept(true)
                case .failure(let error):
                    NotificationBannerHelper.showBanner(error)
                }
            }
        }
    }
}

extension String {
    func validateRepeatField(object: String?) -> ValidationResult {
        guard let secondString = object, !secondString.isEmpty else {
            return .noResult
        }

        if self == secondString {
            return .success
        } else {
            return .error("Incorrect repeate")
        }
    }
}
