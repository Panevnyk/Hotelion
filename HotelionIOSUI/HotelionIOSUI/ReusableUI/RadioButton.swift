//
//  RadioButton.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 24.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI

struct RadioButton: View {
    private let sideLength: CGFloat = 36
    private let innerSideLength: CGFloat = 34

    @State
    var isSelected: Bool

    var didSelect: ((_ isSelected: Bool) -> Void)?

    var body: some View {
        Button(action: tapAction, label: {
            Image(isSelected ? "selectedCheckbox" : "nonSelectedCheckbox")
                .resizable(capInsets: .zero, resizingMode: .stretch)
                .frame(width: 24, height: 24)
                .foregroundColor(isSelected ? Color.kBlue : Color.kBlue)
        })
    }

    private func tapAction() {
        isSelected.toggle()
        didSelect?(isSelected)
    }
}

struct RadioButton_Previews: PreviewProvider {
    static var previews: some View {
        RadioButton(isSelected: false, didSelect: nil)
    }
}
