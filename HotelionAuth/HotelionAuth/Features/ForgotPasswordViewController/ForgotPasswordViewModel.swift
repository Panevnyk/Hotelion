//
//  ForgotPasswordViewModel.swift
//  SaleUp
//
//  Created by sxsasha on 15.03.18.
//  Copyright © 2018 Devlight. All rights reserved.
//

import RestApiManager
import RxSwift
import RxCocoa
import HotelionCommon

public protocol ForgotPasswordViewModelProtocol {
    /// To View
    var isSuccessSendObservable: Observable<Bool> { get }

    /// From View
    var emailText: BehaviorRelay<String> { get }

    /// Observables
    var emailValidationResult: Observable<ValidationResult> { get }
    var isValid: Observable<Bool> { get }

    /// Actions
    func sendActions()
}

public final class ForgotPasswordViewModel: ForgotPasswordViewModelProtocol {
    // MARK: - Properties
    // Boundaries
    private let restApiManager: RestApiManager

    // Variables
    private var isSuccessSend = BehaviorRelay<Bool>(value: false)
    var loginInfo = BehaviorRelay<LoginInfo>(value: LoginInfo())

    // Validators
    private var emailValidator = EmailValidator()

    // From View
    public var emailText = BehaviorRelay<String>(value: "")

    // Observables
    public lazy var isSuccessSendObservable = isSuccessSend.asObservable()

    public var emailValidationResult: Observable<ValidationResult> {
        return emailText.asObservable().map({ (email) -> ValidationResult in
            return self.emailValidator.validate(email)
        })
    }

    public var isValid: Observable<Bool> {
        return emailValidationResult.map({ $0.isValid })
    }

    // MARK: - Inits
    public init(restApiManager: RestApiManager) {
        self.restApiManager = restApiManager
    }
}

// MARK: - RestApiable
extension ForgotPasswordViewModel {
    public func sendActions() {
//        let parameters = ForgotPasswordParameters(email: emailText.value)
//
//        ActivityIndicatorHelper.shared.show()
//        let method = AuthRestApiMethods.forgotPassword(parameters)
//        restApiManager.call(method: method) { [weak self] (result: Result<SuccessResponse>) in
//            DispatchQueue.main.async {
//                ActivityIndicatorHelper.shared.hide()
//                switch result {
//                case .success:
//                    self?.isSuccessSend.accept(true)
//                case .failure(let error):
//                    (error as? SURestApiError)?.showBanner()
//                }
//            }
//        }
    }
}
