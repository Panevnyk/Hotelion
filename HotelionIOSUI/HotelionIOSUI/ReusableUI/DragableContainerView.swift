//
//  DragableContainerView.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 22.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI

struct DragableContainerView<Content>: View where Content: View  {
    //    @State public var yDragPosition: CGSize = .zero
    //    @State private var containerRect: CGRect = CGRect()

    var containerColor: Color  {
        Color(self.showModal.wrappedValue
                ? UIColor.black.withAlphaComponent(0.0001)
                : UIColor.clear)
    }

    var showModal: Binding<Bool>
    var content: () -> Content

    public var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()

                VStack(alignment: .center, spacing: 16) {
                    mover

                    content()
                }
                .padding(.top, 24)
                //            .background(GeometryGetter())
                //            .onPreferenceChange(RectPreferenceKey.self, perform: {
                //                print("!!!! containerRect: \($0)")
                //                self.containerRect = $0
                //            })
                .background(Color.white)
                .cornerRadius(40)
                .shadow(color: Color(UIColor.black.withAlphaComponent(0.15)), radius: 10, x: 0, y: -4)
                .offset(x: 0, y: offsetY(by: geo))
                .dismissTapGesture()
                //            .gesture(
                //                DragGesture().onChanged { (value) in
                //                    self.yDragPosition = value.translation
                //                }.onEnded { _ in
                //                    //                        self.yDragPosition = .zero
                //                }
                //            )

            }
            .background(self.containerColor)
            .edgesIgnoringSafeArea(.bottom)
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(minHeight: 0, maxHeight: .infinity)
//            .gesture(TapGesture().onEnded({ _ in
//                withAnimation(.linear(duration: 0.25)) {
//                    self.showModal.wrappedValue.toggle()
//                }
//            }))
        }
    }

    func offsetY(by geo: GeometryProxy) -> CGFloat {
        return showModal.wrappedValue ? 0 : (geo.size.height + geo.safeAreaInsets.bottom + geo.safeAreaInsets.top)
    }

    func maxHeight(by geo: GeometryProxy) -> CGFloat {
        return geo.size.height// - (geo.safeAreaInsets.bottom + geo.safeAreaInsets.top)
    }

    var mover: some View {
        Rectangle()
            .frame(width: 44, height: 6, alignment: .center)
            .background(Color.kMain)
            .cornerRadius(3)
            .padding(.bottom, 8)
    }

    func yPosition(by dragValue: CGSize, currentRect: CGRect) -> CGFloat {
        return showModal.wrappedValue ? 0 : 400
    }
}

struct DragableContainerView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
