//
//  QuestionnaireForSettlingAssembly.swift
//  HotelionMain
//
//  Created by Vladyslav Panevnyk on 10.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import HotelionDomain
import HotelionIOSUI

final class QuestionnaireForSettlingAssembly {
    let viewModel: QuestionnaireForSettlingInteractorOutput
    let interactor: QuestionnaireForSettlingInteractorInput
    var view: QuestionnaireForSettlingView

    init(serviceFactory: ServiceFactoryProtocol,
         coordinatorDelegate: QuestionnaireForSettlingCoordinatorDelegate) {
        let viewModel = QuestionnaireForSettlingViewModel(coordinatorDelegate: coordinatorDelegate)
        let interactor = QuestionnaireForSettlingInteractor(output: viewModel)
        let view = QuestionnaireForSettlingView(viewModel: viewModel)

        viewModel.interactor = interactor

        self.viewModel = viewModel
        self.interactor = interactor
        self.view = view
    }
}
