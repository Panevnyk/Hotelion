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

    // From View
    var firstnameText: BehaviorRelay<String> { get }
    var lastnameText: BehaviorRelay<String> { get }
    var emailText: BehaviorRelay<String> { get }
    var phoneNumberText: BehaviorRelay<String> { get }
    var passwordText: BehaviorRelay<String> { get }

    // Observables
    var firstnameValidationResult: Observable<ValidationResult> { get }
    var lastnameValidationResult: Observable<ValidationResult> { get }
    var emailValidationResult: Observable<ValidationResult> { get }
    var phoneNumberValidationResult: Observable<ValidationResult> { get }
    var passwordValidationResult: Observable<ValidationResult> { get }

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
    private var firstnameValidator: ValidatorProtocol = TextValidator()
    private var lastnameValidator: ValidatorProtocol = TextValidator()
    private var emailValidator: ValidatorProtocol = EmailValidator()
    private var phoneNumberValidator: ValidatorProtocol = PhoneNumberValidator()
    private var passwordValidator: ValidatorProtocol = PasswordValidator()

    // From View
    public var firstnameText = BehaviorRelay<String>(value: "")
    public var lastnameText = BehaviorRelay<String>(value: "")
    public var emailText = BehaviorRelay<String>(value: "")
    public var phoneNumberText = BehaviorRelay<String>(value: "")
    public var passwordText = BehaviorRelay<String>(value: "")

    // Observables
    public lazy var isSuccessRegisterObservable = isSuccessRegister.asObservable()

    public var firstnameValidationResult: Observable<ValidationResult> {
        return firstnameText.asObservable().map({ [unowned self] (name) -> ValidationResult in
            return self.firstnameValidator.validate(name)
        })
    }

    public var lastnameValidationResult: Observable<ValidationResult> {
        return lastnameText.asObservable().map({ [unowned self] (name) -> ValidationResult in
            return self.lastnameValidator.validate(name)
        })
    }

    public var emailValidationResult: Observable<ValidationResult> {
        return emailText.asObservable().map({ (email) -> ValidationResult in
            return self.emailValidator.validate(email)
        })
    }

    public var phoneNumberValidationResult: Observable<ValidationResult> {
        return phoneNumberText.asObservable().map({ [unowned self] (value) -> ValidationResult in
            return self.phoneNumberValidator.validate(value)
        })
    }

    public var passwordValidationResult: Observable<ValidationResult> {
        return passwordText.asObservable().map({ (password) -> ValidationResult in
            return self.passwordValidator.validate(password)
        })
    }

    public var isValid: Observable<Bool> {
        return Observable.combineLatest(
            firstnameValidationResult,
            lastnameValidationResult,
            emailValidationResult,
            phoneNumberValidationResult,
            passwordValidationResult
        ) { firstname, lastname, email, phone, password in
            return firstname.isValid
                && lastname.isValid
                && email.isValid
                && phone.isValid
                && password.isValid
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
        let parameters = SignupParameters(firstname: firstnameText.value,
                                          lastname: lastnameText.value,
                                          email: emailText.value,
                                          phoneNumber: phoneNumberText.value,
                                          password: passwordText.value)
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
