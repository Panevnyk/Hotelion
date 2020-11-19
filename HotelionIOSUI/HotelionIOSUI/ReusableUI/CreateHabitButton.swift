//
//  CreateHabitButton.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 11.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI
import Combine

struct CreateHabitButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "pencil.tip.crop.circle.badge.plus")
                .imageScale(.large)
                .accessibility(label: Text("User Profile"))
                .padding()
        }
    }
}

struct CreateHabitButton_Previews: PreviewProvider {
    static var previews: some View {
        CreateHabitButton(action: {})
    }
}
