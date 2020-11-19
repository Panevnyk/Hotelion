//
//  QuestionnaireForSettlingInteractor.swift
//  HotelionDomain
//
//  Created by Vladyslav Panevnyk on 10.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation

public typealias BoolResultClosure = ((Result<Bool, NSError>) -> Void)

public protocol QuestionnaireForSettlingInteractorInput {
    func send(questionnaireForSettling: QuestionnaireForSettling)
}

public protocol QuestionnaireForSettlingInteractorOutput {
    func presentQuestionnaireForSettlingSuccessfulySended()
    func present(error: NSError)
}

public protocol QuestionnaireForSettlingDataAccessBoundary {
    func send(questionnaireForSettling: QuestionnaireForSettling, completion: @escaping BoolResultClosure)
}

public class QuestionnaireForSettlingInteractor: QuestionnaireForSettlingInteractorInput {
    private let output: QuestionnaireForSettlingInteractorOutput
//    private let dataAccessBoundary: QuestionnaireForSettlingDataAccessBoundary

    public init(output: QuestionnaireForSettlingInteractorOutput) {
        self.output = output
//        self.dataAccessBoundary = dataAccessBoundary
    }

    public func send(questionnaireForSettling: QuestionnaireForSettling) {
//        dataAccessBoundary.send(questionnaireForSettling: questionnaireForSettling) { [weak self] result in
//            guard let self = self else { return }
//
//            switch result {
//            case .success:
//                self.output.presentQuestionnaireForSettlingSuccessfulySended()
//            case .failure(let error):
//                self.output.present(error: error)
//            }
//        }
    }
}
