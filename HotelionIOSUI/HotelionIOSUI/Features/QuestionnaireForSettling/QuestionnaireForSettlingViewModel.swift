//
//  QuestionnaireForSettlingViewModel.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 09.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import HotelionDomain

public protocol QuestionnaireForSettlingCoordinatorDelegate {
    func questionnaireSendedSuccessfully()
}

public final class QuestionnaireForSettlingViewModel: ObservableObject {
    // MARK: - Properties
    public var interactor: QuestionnaireForSettlingInteractorInput?
    private var coordinatorDelegate: QuestionnaireForSettlingCoordinatorDelegate?

    @Published var firstname: String = "A"
    @Published var secondname: String = "B"
    @Published var dateOfBirth = Date()
    @Published var isShowDatePicker = false
    @Published var error: NSError?

    var isSendButtonDisabled: Binding<Bool> {
        Binding(get: {
            self.firstname.isEmpty || self.secondname.isEmpty
        }) { (newVal) in }
    }

    var isShowErrorAlert: Binding<Bool> {
       Binding(get: {
            self.error != nil
       }) { (newVal) in }
    }

    // MARK: - Init
    public init(coordinatorDelegate: QuestionnaireForSettlingCoordinatorDelegate?) {
        self.coordinatorDelegate = coordinatorDelegate
    }

    // MARK: - Methods
    func send() {
        let questionnaireForSettling = QuestionnaireForSettling(
            firstname: firstname,
            secondname: secondname,
            dateOfBirth: dateOfBirth)
        interactor?.send(questionnaireForSettling: questionnaireForSettling)
    }
}

// MARK: - QuestionnaireForSettlingInteractorOutput
extension QuestionnaireForSettlingViewModel: QuestionnaireForSettlingInteractorOutput {
    public func presentQuestionnaireForSettlingSuccessfulySended() {
        self.error = nil
        coordinatorDelegate?.questionnaireSendedSuccessfully()
    }

    public func present(error: NSError) {
        self.error = error
    }
}
