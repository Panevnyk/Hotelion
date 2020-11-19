//
//  HotelInfoView.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 02.10.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI

public struct HotelInfoView: View {
    // MARK: - Properties
    private let viewModel: HotelInfoViewModel

    // MARK: - Init
    public init(viewModel: HotelInfoViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body
    public var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 32) {
                Text("""
                Providing free transfer to ski lifts, this hotel features a heated outdoor pool and sauna. It is set in near by village, 1.2 km from the Ski Resort.

                There is a spa complex on site, that offers 4 types of sauna (such as hamam, Finnish sauna, Roman-style steam room and a steam bath), swimming pool and kid's pool, spa bath, experience shower, salt chamber as well as gym and different spa treatments.

                Each room and cottage at park Hotel includes a country-style décor, wooden furnishings and a flat-screen TV. Bathrooms are fitted with a hairdryer.

                Our restaurant serves Ukrainian cuisine, and younger guests benefit from the children’s menu. Meals can be enjoyed on the terrace.

                Guests of Hotel can relax in the sauna or on the sun terrace by the pool. Ski rental service and storage are also available on site.

                We speak your language!
                """)

                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.horizontal, 16)
            .navigationBarTitle("SPA resort")
            .navigationBarItems(leading:
                Button(action: {
                    self.viewModel.dismissDidTap()
                }, label: {
                    Image("back", bundle: Bundle.uiModuleBundle)
                })
            )
        }
    }
}

struct HotelInfoView_Previews: PreviewProvider {
    static var previews: some View {
        HotelInfoView(viewModel: HotelInfoViewModel(coordinatorDelegate: nil))
    }
}
