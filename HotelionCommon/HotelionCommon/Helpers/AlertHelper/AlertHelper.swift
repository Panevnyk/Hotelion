//
//  AlertHelper.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 04.12.2020.
//

import UIKit

public final class AlertHelper: NSObject {
    public static func showError(message: String,
                                 action: ((UIAlertAction) -> Void)? = nil) {
        show(title: "Error", message: message, action: action)
    }

    public static func show(title: String?,
                            message: String?,
                            action: ((UIAlertAction) -> Void)? = nil) {
        let alertAction = UIAlertAction(
            title: "Ok",
            style: .default,
            handler: action)

        show(title: title, message: message, alertActions: [alertAction])
    }

    public static func show(title: String?,
                            message: String?,
                            alertActions: [UIAlertAction]) {
        let allertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)

        for alertAction in alertActions {
            allertController.addAction(alertAction)
        }

        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            viewController.present(allertController, animated: true, completion: nil)
        }
    }
}
