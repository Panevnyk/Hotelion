//
//  BaseTapableView.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 17.11.2020.
//

import UIKit
import HotelionCommon

protocol BaseTapableViewDelegate: class {
    func didTapAction(inView view: BaseTapableView)
}

protocol BaseTapableViewAnimationDelegate: class {
    func animateToSelectSize(inView view: BaseTapableView)
    func animateToNormalSize(inView view: BaseTapableView)
}

class BaseTapableView: BaseCustomView {
    /// UI
    private var cardButton: UIButton!

    /// Delegates
    weak var delegate: BaseTapableViewDelegate?
    weak var animationDelegate: BaseTapableViewAnimationDelegate?

    /// initialize
    override func initialize() {
        super.initialize()

        translatesAutoresizingMaskIntoConstraints = false

        cardButton = UIButton(type: .system)
        cardButton.backgroundColor = UIColor.clear
        cardButton.addTarget(self, action: #selector(cardButtonTouchDown), for: .touchDown)
        cardButton.addTarget(self, action: #selector(cardButtonUpInside), for: .touchUpInside)
        cardButton.addTarget(self, action: #selector(cardButtonUpOutSide), for: .touchUpOutside)
        cardButton.addTarget(self, action: #selector(cardButtonCancel), for: .touchCancel)
        addSubviewUsingConstraints(view: cardButton)
    }
}

// MARK: - Actions
private extension BaseTapableView {
    @IBAction func cardButtonTouchDown(_ sender: UIButton) {
        animationDelegate?.animateToSelectSize(inView: self)
    }

    @IBAction func cardButtonUpInside(_ sender: UIButton) {
        animationDelegate?.animateToNormalSize(inView: self)
        delegate?.didTapAction(inView: self)
    }

    @IBAction func cardButtonUpOutSide(_ sender: UIButton) {
        animationDelegate?.animateToNormalSize(inView: self)
    }

    @IBAction func cardButtonCancel(_ sender: UIButton) {
        animationDelegate?.animateToNormalSize(inView: self)
    }
}
