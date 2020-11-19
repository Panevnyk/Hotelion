//
//  QuestionnaireForSettlingInteractorTests.swift
//  HotelionDomain
//
//  Created by Vladyslav Panevnyk on 10.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import XCTest
@testable import HotelionDomain

final class QuestionnaireForSettlingInteractorTests: XCTestCase {
    // MARK: - Properties
    private let outputMock = QuestionnaireForSettlingInteractorOutputMock()
    private let dataAccessBoundaryMock = QuestionnaireForSettlingDataAccessBoundaryMock()

    // MARK: - Tests
    func test() {
        let sut = makeSUT()

        let questionnaireForSettling = QuestionnaireForSettling(
            firstname: "Test firstname",
            secondname: "Test secondname",
            dateOfBirth: makeDate("01/01/2020"))
        sut.send(questionnaireForSettling: questionnaireForSettling)

        let sendedQuestionnaireForSettling = dataAccessBoundaryMock.sendedQuestionnaireForSettling
        XCTAssertEqual(sendedQuestionnaireForSettling?.firstname, "Test firstname")
        XCTAssertEqual(sendedQuestionnaireForSettling?.secondname, "Test secondname")
        XCTAssertEqual(sendedQuestionnaireForSettling?.dateOfBirth, makeDate("01/01/2020"))
    }

    // MARK: - Helpers
    private func makeSUT() -> QuestionnaireForSettlingInteractor {
        let sut = QuestionnaireForSettlingInteractor(output: outputMock, dataAccessBoundary: dataAccessBoundaryMock)
        return sut
    }
}

// MARK: - Mocks
private extension QuestionnaireForSettlingInteractorTests {
    final class QuestionnaireForSettlingDataAccessBoundaryMock: QuestionnaireForSettlingDataAccessBoundary {
        var sendedQuestionnaireForSettling: QuestionnaireForSettling?

        func send(questionnaireForSettling: QuestionnaireForSettling, completion: @escaping BoolResultClosure) {
            sendedQuestionnaireForSettling = questionnaireForSettling
        }
    }

    final class QuestionnaireForSettlingInteractorOutputMock: QuestionnaireForSettlingInteractorOutput {
        func presentQuestionnaireForSettlingSuccessfulySended() {
        }

        func present(error: NSError) {
        }
    }
}
