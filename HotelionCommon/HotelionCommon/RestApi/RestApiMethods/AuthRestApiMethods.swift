//
//  RepositoriesRestApiMethods.swift
//  GitRepositoriesTestApp
//
//  Created by Vladyslav Panevnyk on 02.07.2020.
//  Copyright © 2020 example company. All rights reserved.
//

import RestApiManager

public enum AuthRestApiMethods: RestApiMethod {
    // Method
    case signup(SignupParameters)
    case signin(SigninParameters)
    case currentUser
    case signout

    // URL
    private static let signupURL = "/api/users/signup"
    private static let signinURL = "/api/users/signin"
    private static let currentUserURL = "/api/users/currentUser"
    private static let signoutURL = "/api/users/signout"

    // RestApiData
    public var data: RestApiData {
        switch self {
        case .signup(let parameters):
            return RestApiData(url: RestApiConstants.baseURL + AuthRestApiMethods.signupURL,
                               httpMethod: .post,
                               parameters: parameters)
        case .signin(let parameters):
            return RestApiData(url: RestApiConstants.baseURL + AuthRestApiMethods.signinURL,
                               httpMethod: .post,
                               parameters: parameters)
        case .currentUser:
            return RestApiData(url: RestApiConstants.baseURL + AuthRestApiMethods.currentUserURL,
                               httpMethod: .get)
        case .signout:
            return RestApiData(url: RestApiConstants.baseURL + AuthRestApiMethods.signoutURL,
                               httpMethod: .post)
        }
    }
}
