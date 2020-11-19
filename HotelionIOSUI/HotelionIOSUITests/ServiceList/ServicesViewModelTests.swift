//
//  ServicesViewTests.swift
//  HotelionIOSUITests
//
//  Created by Vladyslav Panevnyk on 21.08.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import XCTest
@testable import HotelionDomain
@testable import HotelionIOSUI

final class ServicesViewModelTests: XCTestCase {
    // MARK: - Properties
    private let servicesInteractorMock = ServicesInteractorMock()

    // MARK: - Tests
    func test_loadServices_interactorMethodCalled() {
        makeSUT().loadServices()
        XCTAssertTrue(servicesInteractorMock.isLoadServicesCalled)
    }

    func test_presentEmptyServices() {
        let sut = makeSUT()

        sut.present(services: [])

        XCTAssertTrue(sut.serviceViewModels.isEmpty)
        XCTAssertNil(sut.error)
    }

    func test_presentTwoServices() {
        let sut = makeSUT()

        let services = [
            Service(id: 1, title: "Test title 1", img: "Test img 1"),
            Service(id: 2, title: "Test title 2", img: "Test img 2")]
        sut.present(services: services)

        XCTAssertEqual(sut.serviceViewModels.count, 2)
        XCTAssertNil(sut.error)

        let firstSUTElement = sut.serviceViewModels[0]
        XCTAssertEqual(firstSUTElement.id, 1)
        XCTAssertEqual(firstSUTElement.title, "Test title 1")
        XCTAssertEqual(firstSUTElement.img, "Test img 1")

        let secondSUTElement = sut.serviceViewModels[1]
        XCTAssertEqual(secondSUTElement.id, 2)
        XCTAssertEqual(secondSUTElement.title, "Test title 2")
        XCTAssertEqual(secondSUTElement.img, "Test img 2")
    }

    func test_presentError() {
        let sut = makeSUT()

        let error = NSError(domain: "Test domain", code: 123, userInfo: nil)
        sut.present(error: error)

        XCTAssertEqual(sut.error?.localizedDescription, "The operation couldn’t be completed. (Test domain error 123.)")
        XCTAssertEqual(sut.serviceViewModels.count, 0)
    }

    // MARK: - Combination of test
    func test_presentCombinationOfResultsTwoServicesAfterError() {
        let sut = makeSUT()

        let error = NSError(domain: "Test domain", code: 123, userInfo: nil)
        sut.present(error: error)

        let services = [
            Service(id: 1, title: "Test title 1", img: "Test img 1"),
            Service(id: 2, title: "Test title 2", img: "Test img 2")]
        sut.present(services: services)

        XCTAssertEqual(sut.serviceViewModels.count, 2)
        XCTAssertNil(sut.error)
    }

    func test_presentCombinationOfResultsErrorAfterTwoServices() {
        let sut = makeSUT()

        let services = [
            Service(id: 1, title: "Test title 1", img: "Test img 1"),
            Service(id: 2, title: "Test title 2", img: "Test img 2")]
        sut.present(services: services)

        let error = NSError(domain: "Test domain", code: 123, userInfo: nil)
        sut.present(error: error)

        XCTAssertEqual(sut.error?.localizedDescription, "The operation couldn’t be completed. (Test domain error 123.)")
        XCTAssertEqual(sut.serviceViewModels.count, 0)
    }

    // MARK: - Helpers
    func makeSUT() -> ServicesViewModel {
        let sut = ServicesViewModel()
        sut.interactor = servicesInteractorMock

        return sut
    }
}

// MARK: - Mocks
extension ServicesViewModelTests {
    final class ServicesInteractorMock: ServicesInteractorInput {
        var isLoadServicesCalled = false

        func loadServices() {
            isLoadServicesCalled = true
        }
    }
}
