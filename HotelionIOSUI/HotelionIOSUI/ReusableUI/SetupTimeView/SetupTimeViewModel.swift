//
//  SetupTimeViewModel.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 22.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Combine
import SwiftUI

public final class SetupTimeViewModel: ObservableObject {
    // MARK: - Properties
//    var showModal: Binding<Bool>
    var selectedDate: Binding<Date>

    @Published var title: String

    // MARK: - Init
    public init(//showModal: Binding<Bool>,
                selectedDate: Binding<Date>,
                title: String) {
//        self.showModal = showModal
        self.selectedDate = selectedDate
        self.title = title
    }

    func doneAction() {
        
//        withAnimation(.linear(duration: 0.25)) {
//            self.showModal = .constant(false)
//        }
    }
}

extension SetupTimeViewModel {
    static var hiddenState: SetupTimeViewModel {
        SetupTimeViewModel(//showModal: .constant(false),
                           selectedDate: .constant(Date()),
                           title: "Empty")
    }
}
