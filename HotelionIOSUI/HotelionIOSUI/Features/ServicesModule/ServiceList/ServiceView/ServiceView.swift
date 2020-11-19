//
//  ServiceView.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 14.08.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI

struct ServiceView: View {
    @ObservedObject
    var viewModel: ServiceViewModel

//    @State var isScaling = false

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()

                    BadgeView(title: $viewModel.badgeTitle)
                        .isHidden(viewModel.badgeTitle == nil, remove: true)
                }
                Spacer()
            }

            VStack {
                VStack(alignment: .center, spacing: 12) {
                    Image(viewModel.img,
                          bundle: Bundle.uiModuleBundle)
                    Text(viewModel.title)
                        .font(Font.system(size: 17, weight: .semibold, design: .default))
                        .lineLimit(2)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                }
            }
        }

//        .scaleEffect(isScaling ? 0.8 : 1, anchor: UnitPoint(x: 0.5, y: 0.5))
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(minHeight: 0, maxHeight: .infinity)
        .background(Color.kGray)
        .cornerRadius(8)
//        .gesture(TapGesture().onEnded {
//            withAnimation(.easeIn(duration: 0.15)) {
//                self.isScaling = true
//
//                withAnimation(.easeOut(duration: 0.15)) {
//                    self.isScaling = false
//                }
//            }
//        })
    }
}

extension ServiceView {
    static var empty: ServiceView {
        ServiceView(viewModel: ServiceViewModel(id: -1, title: "", img: ""))
    }
}

struct ServiceView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceView(viewModel: ServiceViewModel(id: 0, title: "Cleaning", img: ""))
    }
}
