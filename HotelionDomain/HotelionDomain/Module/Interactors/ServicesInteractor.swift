//
//  ServicesInteractor.swift
//  HotelionDomain
//
//  Created by Vladyslav Panevnyk on 21.08.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation

public protocol ServicesInteractorInput: class {
    func loadServices()
}

public protocol ServicesInteractorOutput {
    func present(services: [Service])
    func present(error: Error)
}

public class ServicesInteractor: ServicesInteractorInput {
    private let output: ServicesInteractorOutput

    public init(output: ServicesInteractorOutput) {
        self.output = output
    }

    public func loadServices() {
        output.present(services: [
            Service(id: 0, title: "Cleaning", img: "cleaning", selectedDate: Date()),
            Service(id: 1, title: "Washing", img: "washing"),
            Service(id: 2, title: "SPA procedure", img: "towel_replacement"),
            Service(id: 3, title: "Taxi", img: "taxi"),
            Service(id: 4, title: "Wake-up call", img: "wake-up_call"),
        ])
    }
}
