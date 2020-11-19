//
//  HabitCreationDateView.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 12.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI
import Combine

struct KeyValueDatePickerView: View {
    @State
    var keyText: String
    @Binding
    var selectedDate: Date
    @Binding
    var isShowDatePicker: Bool

    private let dateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "MM/dd/yyyy"
       dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)!
       return dateFormatter
    }()

    private var valueText: String {
        return dateFormatter.string(from: selectedDate)
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(self.keyText)
                        .foregroundColor(.kSecondMain)

                    Spacer()

                    Text(self.valueText)
                        .foregroundColor(.kSecondMain)

                    Image("rightArrow")
                        .resizable(capInsets: .zero, resizingMode: .stretch)
                        .renderingMode(.template)
                        .foregroundColor(.kSecondMain)
                        .frame(width: 20, height: 20)
                }
                .frame(height: 40)
                .zIndex(2)
                .gesture(TapGesture().onEnded {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        self.isShowDatePicker.toggle()
                    }
                })

                DatePicker("", selection: self.$selectedDate, displayedComponents: .date)
                    .labelsHidden()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .frame(height: self.isShowDatePicker ? 218 : 0)
                    .opacity(self.isShowDatePicker ? 1 : 0)
                    .clipped()

                Divider()
            }
        }
    }
}

struct KeyValueDatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        KeyValueDatePickerView(keyText: "Key Test",
                               selectedDate: .constant(Date()),
                               isShowDatePicker: .constant(true))
    }
}
