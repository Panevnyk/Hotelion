//
//  CloseButton.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 12.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI

struct CloseButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image("close")
                .resizable(capInsets: .zero, resizingMode: .stretch)
                .frame(width: 20, height: 20)
        }
        .frame(width: 40, height: 40)
    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton(action: {})
    }
}
