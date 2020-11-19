//
//  KeyValueAction.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 12.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI

class ActionSheetContent {
    var title: String
    var values: [String]

    init(title: String,
         values: [String]) {

        self.title = title
        self.values = values
    }
}

struct KeyValueActionSheetView: View {
    var keyText: String
    var actionSheetContent: ActionSheetContent
    @Binding
    var selectedIndex: Int

    @State
    private var showActionSheet = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(self.keyText)
                    .foregroundColor(Color.gray)

                Spacer()

                Text(actionSheetContent.values[selectedIndex])
                    .foregroundColor(Color.gray)

                Image("rightArrow")
                    .resizable(capInsets: .zero, resizingMode: .stretch)
                    .renderingMode(.template)
                    .foregroundColor(.blue)
                    .frame(width: 20, height: 20)
            }
            .frame(height: 40)

            Divider()
        }
        .gesture(TapGesture().onEnded {
            self.showActionSheet.toggle()
        })
        .actionSheet(isPresented: $showActionSheet) {
            var buttons: [ActionSheet.Button] = actionSheetContent.values.enumerated().map { (arg) in
                return .default(Text(arg.element)) {
                    self.selectedIndex = arg.offset
                }
            }
            buttons.append(.cancel())

            return ActionSheet(title: Text(actionSheetContent.title),
                               buttons: buttons)
        }
    }
}

struct KeyValueAction_Previews: PreviewProvider {
    static var previews: some View {
        KeyValueActionSheetView(keyText: "Key Test",
                                actionSheetContent: ActionSheetContent(title: "title", values: ["v"]),
                                selectedIndex: .constant(0))
    }
}
