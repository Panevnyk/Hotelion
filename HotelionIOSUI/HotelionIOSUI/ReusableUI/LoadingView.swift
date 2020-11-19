//
//  LoadingView.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 14.08.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI

struct LoadingView<Content>: View where Content: View {
    @Binding
    var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                self.content()
                    .disabled(self.isShowing)

                VStack {
                    ActivityIndicator(shouldAnimate: .constant(true), style: .large)
                }
                .frame(width: geometry.size.width / 4,
                       height: geometry.size.height / 10)
                    .background(Color(.quaternarySystemFill))
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)

            }
        }
    }

}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isShowing: .constant(true), content: { Text("Test") })
    }
}
