//
//  View+DismissTapGesture.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 23.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI

extension View {
    @ViewBuilder func dismissTapGesture() -> some View {
        self.onTapGesture {}
    }
}
