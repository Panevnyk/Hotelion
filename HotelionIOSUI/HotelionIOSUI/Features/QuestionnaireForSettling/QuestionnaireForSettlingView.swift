//
//  QuestionnaireForSettlingView.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 09.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI

public struct QuestionnaireForSettlingView: View {
    // MARK: - Properties
    @ObservedObject
    private var viewModel: QuestionnaireForSettlingViewModel

    // MARK: - Init
    public init(viewModel: QuestionnaireForSettlingViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body
    public var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Questionnaire for settling")
                        .font(.largeTitle)
                }

                MaterialTextField(
                    placeHolder: "Firstname",
                    inputText: $viewModel.firstname
                )
                    .frame(height: 48)

                MaterialTextField(
                    placeHolder: "Secondname",
                    inputText: $viewModel.secondname
                )
                    .frame(height: 48)

                KeyValueDatePickerView(
                    keyText: "Date of birth",
                    selectedDate: $viewModel.dateOfBirth,
                    isShowDatePicker:  $viewModel.isShowDatePicker
                )
                    .frame(height: viewModel.isShowDatePicker ? 266 : 48)

                MainButton(
                    title: "Send",
                    isDisabled: viewModel.isSendButtonDisabled,
                    action: sendAction
                )

                Spacer()

            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .alert(isPresented: viewModel.isShowErrorAlert) {
                Alert(title: Text("Error"),
                      message: Text(viewModel.error?.localizedDescription ?? ""),
                      dismissButton: .default(Text("Ok"), action: { self.viewModel.error = nil }))
            }
        }
    }
}

// MARK: - Actions
private extension QuestionnaireForSettlingView {
    func sendAction() {
        viewModel.send()
    }
}
struct QuestionnaireForSettlingView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionnaireForSettlingView(viewModel: QuestionnaireForSettlingViewModel(coordinatorDelegate: nil))
    }
}
