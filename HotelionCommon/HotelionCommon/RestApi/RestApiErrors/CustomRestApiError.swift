//
//  CustomRestApiError.swift
//  GitRepositoriesTestApp
//
//  Created by Vladyslav Panevnyk on 02.07.2020.
//  Copyright © 2020 example company. All rights reserved.
//

import RestApiManager

public struct CustomRestApiError: RestApiError {
    // MARK: - Properties
    public var code: Int
    public var details: String

    public var error: Error {
        return NSError(domain: "", code: code, userInfo: ["errors": [details]])
    }

    // MARK: - Inits
    public init() {
        self.init(code: 0)
    }

    public init(error: Error) {
        let nsError = error as NSError
        self.init(code: nsError.code, details: nsError.localizedDescription)
    }

    public init(code: Int) {
        self.init(code: code, details: "")
    }

    public init(code: Int, details: String) {
        self.code = code
        self.details = details
    }

    // MARK: - Handle

    /// method for handle error by response, if parse to Error success, method will be return Error
    ///
    /// - Parameters:
    ///   - error: Error?
    ///   - urlResponse: URLResponse?
    ///   - data: Data? for parsing to Error
    /// - Returns: ExampleRestApiError
    public static func handle(error: Error?, urlResponse: URLResponse?, data: Data?) -> CustomRestApiError? {
        if let error = error {

            return CustomRestApiError(error: error)

        } else if let data = data {
            guard !data.isEmpty else { return nil }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject],
                    let errors = json[RestApiConstants.errors] as? [[String: AnyObject]],
                    let error = errors.first,
                    let message = error[RestApiConstants.message] as? String {

                    let code = (urlResponse as? HTTPURLResponse)?.statusCode ?? 444
                    let errorRes = CustomRestApiError(code: code, details: message)

                    return errorRes
                } else {

                    return nil
                }
            } catch let error as NSError {

                return CustomRestApiError(error: error)
            }
        } else {

            return CustomRestApiError.unknown
        }
    }
}
