//
//  BaseLoginViewModel.swift
//  SaleUp
//
//  Created by sxsasha on 21.03.18.
//  Copyright © 2018 Devlight. All rights reserved.
//

import RestApiManager
import RxSwift
import RxCocoa

public class LoginUsingSocialNetwork {
    /// Variables
    public var successLogined = BehaviorRelay<Bool>(value: false)
//    public var successLoginedWithShowAddAccounts = BehaviorRelay<Bool>(value: false)
    
    /// Observables
    public lazy var successLoginedObservable = successLogined.asObservable()
//    public lazy var successLoginedWithShowAddAccountsObservable = successLoginedWithShowAddAccounts.asObservable()
}

// MARK: - Actions
extension LoginUsingSocialNetwork {
//    func login(by network: SocialNetwork) {
//        ActivityIndicatorHelper.shared.show()
//        SocialNetworksManager.sharedManager.login(by: network) { [weak self] (result) in
//            if let socialResult = result {
//                let method = AuthRestApiMethods.socialSignIn(socialResult)
//                self?.restApiManager.call(method: method) { [weak self] (result: Result<SocialLoginInfo>) in
//                    DispatchQueue.main.async {
//                        switch result {
//                        case .success(let socialLoginInfo):
//                            let loginInfo = LoginInfo(socialLoginInfo: socialLoginInfo,
//                                                      name: socialResult.name)
//                            self?.saveUserAndCheckEbayAccounts(loginInfo: loginInfo,
//                                                               email: socialResult.email,
//                                                               password: "")
//                        case .failure(let error):
//                            ActivityIndicatorHelper.shared.hide()
//                            (error as? SURestApiError)?.showBanner()
//                        }
//                    }
//                }
//            } else {
//                DispatchQueue.main.async {
//                    ActivityIndicatorHelper.shared.hide()
//                }
//            }
//        }
//    }
    
    func saveUserAndCheckEbayAccounts(loginInfo: LoginInfo, email: String, password: String) {
        /// Save User
//        UserData.shared.saveUserAfterLogin(loginInfo: loginInfo, email: email, password: password)
//        /// Load Ebay accounts and Permissions
//        EbayAccountsManager.shared.loadAccountData { [weak self] in
//            DispatchQueue.main.async {
//                ActivityIndicatorHelper.shared.hide()
//                if EbayAccountsManager.shared.allEbayAccounts.count > 0 {
//                    self?.successLogined.accept(true)
//                } else {
//                    self?.successLoginedWithShowAddAccounts.accept(true)
//                }
//            }
//        }
    }
}
