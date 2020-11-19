//
//  Instantiable.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 29.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit

enum Storyboard: String, CaseIterable {
    case booking = "Booking"
}

extension Storyboard {
    var viewControllers: [String] {
        switch self {
        case .booking:
            return [BookingViewController.name]
        }
    }
}

extension Storyboard {
    static func value(byViewController viewController: UIViewController.Type) -> Storyboard {
        for storyboard in Storyboard.allCases
            where storyboard.viewControllers.contains(viewController.name) {
                return storyboard
        }

        fatalError("ViewController: \"\(viewController.name)\" is not defined in Storyboard enum")
    }
}

public protocol Instantiable: class {}

extension Instantiable where Self: UIViewController {
    public static var instantiate: Self {
        let storyboardValue = UIStoryboard(name: Storyboard.value(byViewController: self).rawValue,
                                           bundle: Bundle.uiModuleBundle)
        guard let viewController = storyboardValue.instantiateViewController(withIdentifier: name) as? Self else {
            fatalError("ViewController: \"\(name)\" incorrect cast to \(Self.name)")
        }
        return viewController
    }
}

extension UIViewController: Instantiable {
    static var name: String {
        return String(describing: self)
    }
}

