//
//  ServicesInteractorTests.swift
//  HotelionDomain
//
//  Created by Vladyslav Panevnyk on 21.08.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import XCTest
@testable import HotelionDomain

final class ServicesInteractorTests: XCTestCase {
    // MARK: - Properties
    let outputMock = ServicesInteractorOutputMock()

    // MARK: - Tests

    // MARK: - Helpers
    func makeSUT() -> ServicesInteractor {
        let sut = ServicesInteractor(output: outputMock)

        return sut
    }
}

extension ServicesInteractorTests {
    final class ServicesInteractorOutputMock: ServicesInteractorOutput {
        var presenterServices: [Service]?
        var presenterError: Error?

        func present(services: [Service]) {
            presenterServices = services
        }

        func present(error: Error) {
            presenterError = error
        }
    }
}
