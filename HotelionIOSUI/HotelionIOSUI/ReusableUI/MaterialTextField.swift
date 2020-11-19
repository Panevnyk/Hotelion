//
//  MaterialTextField.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 09.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI
import Combine

struct MaterialTextField: View {
    var placeHolder: String
    @Binding
    var inputText: String
    @State
    private var isEditing = false
    private var isPlaceholderOnTheTop: Binding<Bool> {
        Binding(get: {
            self.isEditing || !self.inputText.isEmpty
        }) { (newVal) in }
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Text(self.placeHolder)
                    .foregroundColor(self.isPlaceholderOnTheTop.wrappedValue ? .kMain : .kSecondMain)
                    .offset(x: 0, y: self.isPlaceholderOnTheTop.wrappedValue ? -30 : 2)
                    .scaleEffect(self.isPlaceholderOnTheTop.wrappedValue ? 0.8 : 1, anchor: UnitPoint(x: 0, y: 0))

                TextField("", text: self.$inputText, onEditingChanged: { isEditing in
                    withAnimation(.easeInOut) {
                        self.isEditing.toggle()
                    }
                })
                .frame(height: 40)
                .offset(x: 0, y: 2)

                Divider()
                    .offset(x: 0, y: 20)
            }
            
            .frame(height: 48)
        }
    }
}

struct MaterialTextField_Previews: PreviewProvider {
    static var previews: some View {
        MaterialTextField(placeHolder: "Test placeholder", inputText: .constant(""))
    }
}
