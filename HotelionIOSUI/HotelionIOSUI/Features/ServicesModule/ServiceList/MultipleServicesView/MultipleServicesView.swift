//
//  MultipleServicesView.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 30.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI

struct MultipleServicesView: View {
    @ObservedObject
    var viewModel: MultipleServicesViewModel

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 15) {
                Button {
                    withAnimation(.easeIn(duration: 0.25)) {
                        self.viewModel.doNotDisturb.toggle()
                    }
                } label: {
                    ZStack() {
                        Image(viewModel.doNotDisturb
                            ? "do-not-disturb-on"
                            : "do-not-disturb",
                              bundle: Bundle.uiModuleBundle)
                            .offset(x: dontDisturbImageInnerOffset(by: geometry))

                        Text(viewModel.doNotDisturb
                                ? "Do not\ndisturb On"
                                : "Do not\ndisturb Off")
                            .font(Font.system(size: 15, weight: .semibold, design: .default))
                            .lineLimit(2)
                            .foregroundColor(viewModel.doNotDisturb
                                ? Color.white
                                : Color.black)
                            .multilineTextAlignment(.center)
                            .offset(x: dontDisturbLabelInnerOffset(by: geometry))
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: cellSide(by: geometry))
                .background(viewModel.doNotDisturb
                            ? Color.kBlue
                            : Color.kGray)
                .cornerRadius(8)

                HStack(alignment: .center, spacing: 15) {
                    Button {
                        presentPhoneAlert()
                    } label: {
                        Image("phone", bundle: Bundle.uiModuleBundle)
                    }
                    .frame(height: cellSide(by: geometry))
                    .frame(width: cellSide(by: geometry))
                    .background(Color.kGray)
                    .cornerRadius(8)

                    Button {} label: {
                        Image("message",
                              bundle: Bundle.uiModuleBundle)
                    }
                    .frame(height: cellSide(by: geometry))
                    .frame(width: cellSide(by: geometry))
                    .background(Color.kGray)
                    .cornerRadius(8)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
            }
        }
    }

    public func presentPhoneAlert() {
        let callToReceptionAction = AlertViewAction(title: "Call to reception", style: .default) {
            viewModel.callTo(number: "+380500551370")
        }
        let callToSPAReceptionAction = AlertViewAction(title: "Call to SPA reception", style: .default) {
            viewModel.callTo(number: "+380000000000")
        }
        let cancelAction = AlertViewAction(style: .cancel)
        let alertVC = AlertViewController(
            title: "Please, select recipient",
            actions: [callToReceptionAction, callToSPAReceptionAction, cancelAction])
        alertVC.present()
    }

    private func dontDisturbImageInnerOffset(by geometry: GeometryProxy) -> CGFloat {
        return -((geometry.size.height / 4) + 7.5)
    }

    private func dontDisturbLabelInnerOffset(by geometry: GeometryProxy) -> CGFloat {
        return (geometry.size.height / 4) - 15
    }

    private func cellSide(by geometry: GeometryProxy) -> CGFloat {
        return (geometry.size.height - 15) / 2
    }
}

struct MultipleServicesView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleServicesView(viewModel: MultipleServicesViewModel())
    }
}
