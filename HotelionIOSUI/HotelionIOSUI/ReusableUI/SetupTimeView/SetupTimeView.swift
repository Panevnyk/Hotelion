//  SetupTimeView.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 17.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation
import SwiftUI

public struct SetupTimeView: View {
    var showModal: Binding<Bool>
    @ObservedObject
    private var viewModel: SetupTimeViewModel

    public init(showModal: Binding<Bool>, viewModel: SetupTimeViewModel) {
        self.showModal = showModal
        self.viewModel = viewModel
    }

    public var body: some View {
        DragableContainerView(showModal: showModal) {
            VStack(alignment: .center, spacing: 16) {
                HStack {
                    Text(self.viewModel.title)
                        .font(Font.system(size: 17))

                    Spacer()

                    Button(action: self.doneAction) {
                        Text("Done")
                            .font(Font.system(size: 18, weight: .bold, design: .default))
                            .foregroundColor(.kBlue)
                    }
                }

                DatePicker("", selection: self.viewModel.selectedDate, displayedComponents: .hourAndMinute)
                    .labelsHidden()
            }
            .padding([.leading, .trailing], 24)
            .padding(.bottom, 44)
        }
    }

    func doneAction() {
        withAnimation(.linear(duration: 0.25)) {
            self.showModal.wrappedValue.toggle()
        }
//        self.viewModel.doneAction()
    }
}

//struct SetupTimeView_Previews: PreviewProvider {
//    static var previews: some View {
//        SetupTimeView()
//    }
//}
