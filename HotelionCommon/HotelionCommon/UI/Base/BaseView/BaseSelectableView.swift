//
//  BaseSelectableView.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 02.12.2020.
//

import UIKit

public class BaseSelectableView: BaseTapableView {
    public override func initialize() {
        super.initialize()
        animationDelegate = self
    }
}

// MARK: - BaseTapableViewAnimationDelegate
extension BaseSelectableView: BaseTapableViewAnimationDelegate {
    public func animateToSelectSize(inView view: BaseTapableView) {
        UIView.animate(withDuration: 0.1) {
            self.alpha = 0.2
        }
    }

    public func animateToNormalSize(inView view: BaseTapableView) {
        UIView.animate(withDuration: 0.1) {
            self.alpha = 1
        }
    }
}
