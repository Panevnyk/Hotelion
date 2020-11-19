//
//  CalendarView.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 23.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation
import SwiftUI

public struct CalendarDragableView: View {
    var showModal: Binding<Bool>
    @ObservedObject
    private var viewModel: CalendarDragableViewModel

    public init(showModal: Binding<Bool>, viewModel: CalendarDragableViewModel) {
        self.showModal = showModal
        self.viewModel = viewModel
    }

    public var body: some View {
        GeometryReader { geometry in
            DragableContainerView(showModal: showModal) {
                VStack(alignment: .center, spacing: 16) {
                    HStack {
                        Text(self.viewModel.title)
                            .font(Font.system(size: 17))

                        Spacer()

                        Button(action: self.doneAction) {
                            Text("Done")
                                .font(Font.system(size: 18, weight: .bold, design: .default))
                                .foregroundColor(.kBlue)
                        }
                    }
                    .padding([.leading, .trailing], 24)

//                    RepresentableCalendarView()
//                        .frame(width: 100, height: 100)
                }
//                .padding(.bottom, 44)
            }
        }
    }

    private var collectionViewInnerSpacing: (CGFloat, CGFloat) {
        return (CalendarDragableView.Constants.Collection.verticalSpace,
                CalendarDragableView.Constants.Collection.horizontalSpace)
    }

    private var collectionViewOuterInsets: EdgeInsets {
        return EdgeInsets(top: 0,
                          leading: 0,
                          bottom: 0,
                          trailing: 0)
    }

    private func cellWidth(by geometry: GeometryProxy) -> CGFloat {
        let generalSpacing = CalendarDragableView.Constants.Collection.leadingSpace * 2 + (CalendarDragableView.Constants.Collection.horizontalSpace * (CGFloat(CalendarDragableViewModel.columnsCount) - 1))
        return abs((geometry.size.width - generalSpacing) / CGFloat(CalendarDragableViewModel.columnsCount))
    }

    private func cellHeight(by geometry: GeometryProxy) -> CGFloat {
        return 64
    }


    func doneAction() {
        withAnimation(.linear(duration: 0.25)) {
            self.showModal.wrappedValue.toggle()
        }
    }
}

// MARK: - Constants
extension CalendarDragableView {
    enum Constants {
        enum Collection {
            static let verticalSpace: CGFloat = 16
            static let horizontalSpace: CGFloat = 16
            static let leadingSpace: CGFloat = 8
        }
    }
}
