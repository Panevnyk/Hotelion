//
//  RestApiMethod+Headers.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 12.11.2020.
//

import RestApiManager

extension RestApiMethod {
    var defaultHeaders: [String: String] {
        let parameters: [String: String] = [
            RestApiConstants.token: UserData.shared.token
        ]
        return parameters
    }

    var multipartDefaultHeaders: [String: String] {
        let parameters: [String: String] = [
            "Content-Type": "multipart/form-data; boundary=ABC_boundary",
            RestApiConstants.token: UserData.shared.token
        ]
        return parameters
    }
}
