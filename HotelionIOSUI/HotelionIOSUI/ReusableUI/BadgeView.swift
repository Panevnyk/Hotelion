//
//  BadgeView.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 23.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI
import Combine

struct BadgeView: View {
    @Binding var title: String?

    var body: some View {
        VStack {
            Text(title ?? "")
                .font(Font.system(size: 12, weight: .semibold))
                .foregroundColor(.white)
                .padding(.vertical, 3)
                .padding(.horizontal, 6)
        }
        .background(Color.kBlue)
        .cornerRadius(4)
        .padding([.top, .trailing], 6)
    }
}

struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeView(title: .constant("10:30 AM"))
    }
}
