//
//  HotelByCodeParameters.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 19.01.2021.
//

import RestApiManager

public struct HotelByCodeParameters: ParametersProtocol {
    public let code: String

    public init(code: String) {
        self.code = code
    }

    public var parametersValue: Parameters {
        let parameters: [String: Any] = [
            RestApiConstants.code: code
            ]
        return parameters
    }
}

public struct HotelByIdParameters: ParametersProtocol {
    public let id: String

    public init(id: String) {
        self.id = id
    }

    public var parametersValue: Parameters {
        let parameters: [String: Any] = [
            RestApiConstants.id: id
            ]
        return parameters
    }
}
