//
//  AlertAnimable.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 30.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit

struct AlertViewAnimator {
    func show(view: UIView, completition: (() -> Void)? = nil) {
        view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        view.alpha = 0

        UIView.animate(withDuration: 0.2, animations: {
            view.alpha = 1
            view.transform = CGAffineTransform(scaleX: 1, y: 1)

        }, completion: { (_) in
            if let completition = completition {
                completition()
            }
        })
    }

    func hide(view: UIView, completition: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.2, animations: {
            view.alpha = 0

        }, completion: { (_) in
            view.transform = CGAffineTransform.identity

            if let completition = completition {
                completition()
            }
        })
    }
}

