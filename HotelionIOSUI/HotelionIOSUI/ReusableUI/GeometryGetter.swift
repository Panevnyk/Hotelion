//
//  GeometryGetter.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 22.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI

struct RectPreferenceKey: PreferenceKey {
    static var defaultValue = CGRect.zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
//        value = nextValue()
    }

    typealias Value = CGRect
}

struct GeometryGetter: View {
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.red)
                .preference(key: RectPreferenceKey.self, value: geometry.frame(in: .global))
        }
    }
}
