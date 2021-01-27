//
//  AddPersonalInfoViewModel.swift
//  HotelionFastCheckIn
//
//  Created by Vladyslav Panevnyk on 13.01.2021.
//

import RestApiManager
import RxSwift
import RxCocoa
import HotelionCommon

public protocol AddPersonalInfoViewModelProtocol {
    // From View
    var firstname: BehaviorRelay<String> { get }
    var lastname: BehaviorRelay<String> { get }
    var email: BehaviorRelay<String> { get }
    var phoneNumber: BehaviorRelay<String> { get }

    var passportNumber: BehaviorRelay<String> { get }
    var passportFrom: BehaviorRelay<String> { get }
    var nationality: BehaviorRelay<String> { get }
    var placeOfResidence: BehaviorRelay<String> { get }
    var dateOfBirth: BehaviorRelay<String> { get }

    var digitalSignatureStatus: BehaviorRelay<DigitalSignatureStatus> { get }

    // To View
    var firstnameValidationResult: Observable<ValidationResult> { get }
    var lastnameValidationResult: Observable<ValidationResult> { get }
    var emailValidationResult: Observable<ValidationResult> { get }
    var phoneNumberValidationResult: Observable<ValidationResult> { get }

    var passportNumberValidationResult: Observable<ValidationResult> { get }
    var passportFromValidationResult: Observable<ValidationResult> { get }
    var nationalityValidationResult: Observable<ValidationResult> { get }
    var placeOfResidenceValidationResult: Observable<ValidationResult> { get }
    var dateOfBirthValidationResult: Observable<ValidationResult> { get }

    var isPersonalDataValid: Observable<Bool> { get }
    var isPassportDataValid: Observable<Bool> { get }
    var isDigitalSignatureValid: Observable<Bool> { get }
    var isValid: Observable<Bool> { get }

    /// Actions
    func checkInAction()
    func removeDigitalSignatureAction()
}

public protocol AddPersonalInfoViewModelDelegate: class {
    func personalInfoWasAdded()
}

public final class AddPersonalInfoViewModel: AddPersonalInfoViewModelProtocol {
    // MARK: - Properties
    // Boundaries
    private let restApiManager: RestApiManager

    // Delegate
    public weak var delegate: AddPersonalInfoViewModelDelegate?

    // Formatters
    private let dateOfBirthFormatter = DateHelper.shared.dateStyleFormatter

    // Validators
    private let firstnameValidator: ValidatorProtocol =
        TextValidator(errorText: "First name is too short")
    private let lastnameValidator: ValidatorProtocol =
        TextValidator(errorText: "Last name is too short")
    private let emailValidator: ValidatorProtocol =
        EmailValidator()
    private let phoneNumberValidator: ValidatorProtocol =
        PhoneNumberValidator()

    private let passportNumberValidator: ValidatorProtocol =
        PassportNumberValidator()
    private let passportFromValidator: ValidatorProtocol =
        TextValidator(errorText: "Passport from is too short")
    private let nationalityValidator: ValidatorProtocol =
        TextValidator(errorText: "Nationality is too short")
    private let placeOfResidenceValidator: ValidatorProtocol =
        TextValidator(errorText: "Place of residence is too short")
    private let dateOfBirthValidator: ValidatorProtocol =
        DateOfBirthValidator()

    // From View
    public var firstname: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    public var lastname: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    public var email: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    public var phoneNumber: BehaviorRelay<String> = BehaviorRelay<String>(value: "")

    public var passportNumber: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    public var passportFrom: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    public var nationality: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    public var placeOfResidence: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    public var dateOfBirth: BehaviorRelay<String> = BehaviorRelay<String>(value: "")

    public var digitalSignatureStatus = BehaviorRelay<DigitalSignatureStatus>(value: .empty)

    // To View
    // personal data validationResult
    public var firstnameValidationResult: Observable<ValidationResult> {
        return firstname.asObservable().map({ (email) -> ValidationResult in
            return self.firstnameValidator.validate(email)
        })
    }
    public var lastnameValidationResult: Observable<ValidationResult> {
        return lastname.asObservable().map({ (email) -> ValidationResult in
            return self.lastnameValidator.validate(email)
        })
    }
    public var emailValidationResult: Observable<ValidationResult> {
        return email.asObservable().map({ (email) -> ValidationResult in
            return self.emailValidator.validate(email)
        })
    }
    public var phoneNumberValidationResult: Observable<ValidationResult> {
        return phoneNumber.asObservable().map({ (email) -> ValidationResult in
            return self.phoneNumberValidator.validate(email)
        })
    }

    // passport data validationResult
    public var passportNumberValidationResult: Observable<ValidationResult> {
        return passportNumber.asObservable().map({ (email) -> ValidationResult in
            return self.passportNumberValidator.validate(email)
        })
    }
    public var passportFromValidationResult: Observable<ValidationResult> {
        return passportFrom.asObservable().map({ (email) -> ValidationResult in
            return self.passportFromValidator.validate(email)
        })
    }
    public var nationalityValidationResult: Observable<ValidationResult> {
        return nationality.asObservable().map({ (email) -> ValidationResult in
            return self.nationalityValidator.validate(email)
        })
    }
    public var placeOfResidenceValidationResult: Observable<ValidationResult> {
        return placeOfResidence.asObservable().map({ (email) -> ValidationResult in
            return self.placeOfResidenceValidator.validate(email)
        })
    }
    public var dateOfBirthValidationResult: Observable<ValidationResult> {
        return dateOfBirth.asObservable().map({ (email) -> ValidationResult in
            return self.dateOfBirthValidator.validate(email)
        })
    }

    // isValid
    public var isPersonalDataValid: Observable<Bool> {
        return Observable.combineLatest(
            firstnameValidationResult,
            lastnameValidationResult,
            emailValidationResult,
            phoneNumberValidationResult)
        { (firstname, lastname, email, phoneNumber) in
            return firstname.isValid
                && lastname.isValid
                && email.isValid
                && phoneNumber.isValid
        }
    }

    public var isPassportDataValid: Observable<Bool> {
        return Observable.combineLatest(
            passportNumberValidationResult,
            passportFromValidationResult,
            nationalityValidationResult,
            placeOfResidenceValidationResult,
            dateOfBirthValidationResult)
        { (passportNumber, passportFrom, nationality, placeOfResidence, dateOfBirth) in
            return passportNumber.isValid
                && passportFrom.isValid
                && nationality.isValid
                && placeOfResidence.isValid
                && dateOfBirth.isValid
        }
    }

    public var isDigitalSignatureValid: Observable<Bool> {
        return digitalSignatureStatus
            .map{ !$0.isEmpty }
            .asObservable()
    }

    public var isValid: Observable<Bool> {
        return Observable.combineLatest(
            isPersonalDataValid,
            isPassportDataValid,
            isDigitalSignatureValid)
        { (personalData, passportData, digitalSignature) in
            return personalData
                && passportData
                && digitalSignature
        }
    }

    // MARK: - Inits
    public init(restApiManager: RestApiManager) {
        self.restApiManager = restApiManager
    }
}

// MARK: - Actions
extension AddPersonalInfoViewModel {
    public func checkInAction() {
        let dateOfBirthValue = dateOfBirthFormatter
            .date(from: dateOfBirth.value)?
            .timeIntervalSince1970MiliSec
        ?? 0.0

        let parameters = CreateOrUpdateFullUserInfoParameters(
            email: email.value,
            firstname: firstname.value,
            lastname: lastname.value,
            phoneNumber: phoneNumber.value,
            passportNumber: passportNumber.value,
            passportFrom: passportFrom.value,
            nationality: nationality.value,
            placeOfResidence: placeOfResidence.value,
            dateOfBirth: dateOfBirthValue,
            digitalSignature: digitalSignatureStatus.value.signature
        )
        let method = AuthRestApiMethods.createOrUpdateFullUserInfoURL(parameters)

        ActivityIndicatorHelper.shared.show()
        restApiManager.call(method: method) { [weak self] (result: Result<User>) in
            DispatchQueue.main.async {
                ActivityIndicatorHelper.shared.hide()

                switch result {
                case .success(let user):
                    UserData.save(user: user)
                    self?.delegate?.personalInfoWasAdded()
                case .failure(let error):
                    NotificationBannerHelper.showBanner(error)
                }
            }
        }
    }

    public func removeDigitalSignatureAction() {
        digitalSignatureStatus.accept(.empty)
    }
}
