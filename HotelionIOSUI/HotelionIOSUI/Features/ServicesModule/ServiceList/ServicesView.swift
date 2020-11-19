//
//  ServicesView.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 14.08.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI
import HotelionDomain

public struct ServicesView: View {
    // MARK: - Properties
    @ObservedObject
    private var viewModel: ServicesViewModel

    // MARK: - Init
    public init(viewModel: ServicesViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body
    public var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack(alignment: .top) {
                    ScrollView(.vertical) {
                        VStack(spacing: ServicesView.Constants.collectionInnerSpacing.vertical) {
                            Image("spa_resort", bundle: Bundle.uiModuleBundle)
                                .frame(height: self.cellSide(by: geometry))
                                .cornerRadius(8)
                                .padding(.horizontal, ServicesView.Constants.collectionOuterInsets.leading)

                            CollectionView(
                                elementsCount: self.viewModel.serviceViewModels.count + 1,
                                columnsCount: ServicesViewModel.columnsCount,
                                innerSpacings: ServicesView.Constants.collectionInnerSpacing,
                                outerInsets: ServicesView.Constants.collectionOuterInsets,
                                content: { (row, column) in
                                    ServiceItemViewContainer(row: row,
                                                             column: column,
                                                             viewModel: self.viewModel)
                                        .frame(width: self.cellSide(by: geometry),
                                               height: self.cellSide(by: geometry),
                                               alignment: .center)
                                }
                            )
                        }
                    }
                    .navigationBarTitle(Text("SPA resort"))
                    .navigationBarItems(trailing:
                        Button(action: {
                            self.viewModel.hotelInfoDidTap()
                        }, label: {
                            Image("info", bundle: Bundle.uiModuleBundle)
                        })
                    )
                }
                .alert(isPresented: self.$viewModel.isShowErrorAlert) {
                    Alert(title: Text("Error"),
                          message: Text(self.viewModel.error?.localizedDescription ?? ""),
                          dismissButton: .default(Text("Ok"), action: { self.viewModel.error = nil }))
                }
                .onAppear(perform: self.fetchData)
            }
        }
    }

    // MARK: - ServiceItemViewContainer
    struct ServiceItemViewContainer: View {
        let row: Int
        let column: Int
        let viewModel: ServicesViewModel

        var body: some View {
            if row == 0 && column == 0 {
                MultipleServicesView(viewModel: viewModel.makeMultipleServicesViewModel())
            } else {
                ServiceView(viewModel: self.viewModel.serviceViewModels[
                                self.viewModel.makeIndexFrom(row: row, column: column) - 1]
                )
                .gesture(TapGesture().onEnded {
                    self.viewModel.serviceDidTap(row: row, column: column)
                })
            }
        }
    }
}

// MARK: UI
private extension ServicesView {
    private func cellSide(by geometry: GeometryProxy) -> CGFloat {
        let generalSpacing = ServicesView.Constants.collectionOuterInsets.leading * 2
            + ServicesView.Constants.collectionInnerSpacing.horizontal
        return (geometry.size.width - generalSpacing) / CGFloat(ServicesViewModel.columnsCount)
    }
}

// MARK: - Fetch
private extension ServicesView {
    func fetchData() {
        viewModel.loadServices()
    }
}

// MARK: - Constants
extension ServicesView {
    enum Constants {
        static let collectionOuterInsets: EdgeInsets =
            EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30)
        static let collectionInnerSpacing: (vertical: CGFloat, horizontal: CGFloat) =
            (15, 15)
    }
}

// MARK: - PreviewProvider
struct ServicesView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ServicesViewModel(coordinatorDelegate: nil)
        let interactor = ServicesInteractor(output: viewModel)
        viewModel.interactor = interactor
        return ServicesView(viewModel: viewModel)
    }
}
