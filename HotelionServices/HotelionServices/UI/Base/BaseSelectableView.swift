//
//  BaseSelectableView.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 17.11.2020.
//

import UIKit

class BaseSelectableView: BaseTapableView {
    override func initialize() {
        super.initialize()
        animationDelegate = self
    }
}

// MARK: - BaseTapableViewAnimationDelegate
extension BaseSelectableView: BaseTapableViewAnimationDelegate {
    func animateToSelectSize(inView view: BaseTapableView) {
        UIView.animate(withDuration: 0.1) {
            self.alpha = 0.2
        }
    }

    func animateToNormalSize(inView view: BaseTapableView) {
        UIView.animate(withDuration: 0.1) {
            self.alpha = 1
        }
    }
}
