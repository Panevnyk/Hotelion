//
//  MultipleServicesViewModel.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 01.10.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import Combine

final class MultipleServicesViewModel: ObservableObject {
    @Published
    var doNotDisturb: Bool = false

    func callTo(number: String) {
        if let url = URL(string: "tel://\(number)") {
            UIApplication.shared.open(url)
        }
    }
}
