//
//  UIAlertController+CustomView.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 29.01.2021.
//

import UIKit

public extension UIAlertController {
    private struct Constants {
        static let keyContentViewController = "contentViewController"
        static var customViewTag = 112
    }

    convenience init(title: String? = nil,
                     message: String? = nil,
                     customViewController: UIViewController,
                     preferredStyle: UIAlertController.Style,
                     alertActions: [UIAlertAction] = []) {

        self.init(title: title, message: message, preferredStyle: preferredStyle)
        alertActions.forEach { addAction($0) }

        setValue(customViewController, forKey: Constants.keyContentViewController)
    }

    convenience init(title: String? = nil,
                     message: String? = nil,
                     customView: UIView,
                     preferredStyle: UIAlertController.Style,
                     alertActions: [UIAlertAction] = []) {

        customView.tag = Constants.customViewTag

        let viewController = UIViewController()
        viewController.view = customView
        
        self.init(title: title,
                  message: message,
                  customViewController: viewController,
                  preferredStyle: preferredStyle,
                  alertActions: alertActions)
    }
}
