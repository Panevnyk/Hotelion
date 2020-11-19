//
//  CollectionView.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 21.08.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI

struct CollectionView<Content>: View where Content: View {
    var elementsCount: Int = 0
    var columnsCount: Int = 0
    var innerSpacings: (vertical: CGFloat, horizontal: CGFloat)
    var outerInsets: EdgeInsets
    var content: (_ row: Int, _ column: Int) -> Content

    init(elementsCount: Int,
         columnsCount: Int,
         innerSpacings: (vertical: CGFloat, horizontal: CGFloat) = (0, 0),
         outerInsets: EdgeInsets = .zero,
         content: @escaping (_ row: Int, _ column: Int) -> Content
    ) {
        self.innerSpacings = innerSpacings
        self.outerInsets = outerInsets
        self.content = content
        self.elementsCount = elementsCount
        self.columnsCount = columnsCount
    }

    var body: some View {
        VStack(alignment: .center, spacing: self.innerSpacings.vertical) {
            ForEach(0 ..< self.rowsCount, id: \.self) { row in
                HStack(alignment: .top, spacing: self.innerSpacings.horizontal) {
                    ForEach(0 ..< self.columnsCount, id: \.self) { column in
                        if (row * self.columnsCount) + column < self.elementsCount {
                            self.content(row, column)
                        } else {
                            Spacer()
                        }
                    }
                }
            }
        }
        .padding(outerInsets)
    }

    var rowsCount: Int {
        Int(ceil(Double(elementsCount) / 2.0))
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView(elementsCount: 4, columnsCount: 2) { (row, column) in Text("") }
    }
}
