//
//  CheckBoxView.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 11.11.2020.
//

import UIKit

public final class CheckBoxView: BaseCustomView {
    /// checkmarkLayer
    private let checkmarkLayer = CAShapeLayer()
    private let shapesRect = CGRect(x: 0, y: 0, width: 24, height: 24)

    // MARK: - API
    private(set) var isChecked: Bool = false

    public func setChecked(_ checked: Bool, animated: Bool = false) {
        self.isChecked = checked

        if checked {
            if animated {
                checkedWithAnim()
            } else {
                checkedWithoutAnim()
            }
        } else {
            if animated {
                uncheckedWithAnim()
            } else {
                uncheckedWithoutAnim()
            }
        }
    }

    // MARK: - Initialization
    public override func initialize() {
        //customize myself
        backgroundColor = .clear

        initCheckmarkLayer()
    }

    private func initCheckmarkLayer() {
        checkmarkLayer.frame = shapesRect
        checkmarkLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        checkmarkLayer.strokeColor = UIColor.kPaleTealDark.cgColor
        checkmarkLayer.fillColor = UIColor.clear.cgColor
        checkmarkLayer.lineWidth = 2.4
        checkmarkLayer.lineCap = CAShapeLayerLineCap.round
        checkmarkLayer.lineJoin = CAShapeLayerLineJoin.round

        let checkmarkBezier = UIBezierPath()

        let rectWidth = checkmarkLayer.bounds.width
        let pointStart = CGPoint(x: ceil(0.266666666 * rectWidth), y: ceil(0.5 * rectWidth))
        let point0 = CGPoint(x: ceil(0.4444444 * rectWidth), y: ceil(0.65277 * rectWidth))
        let pointEnd = CGPoint(x: ceil(0.770833 * rectWidth), y: ceil(0.30416 * rectWidth))

        checkmarkBezier.move(to: pointStart)
        checkmarkBezier.addLine(to: point0)
        checkmarkBezier.addLine(to: pointEnd)

        checkmarkLayer.path = checkmarkBezier.cgPath
        checkmarkLayer.strokeStart = 0.0
        checkmarkLayer.strokeEnd = 0.0
        self.layer.addSublayer(checkmarkLayer)
    }
}

// MARK: - Create & Add Animations
extension CheckBoxView {
    private func checkedWithAnim() {
        let greenAnimation = createAnimation()
        greenAnimation.fromValue = checkmarkLayer.presentation()?.strokeEnd
        greenAnimation.toValue = 1.0
        checkmarkLayer.removeAllAnimations()
        checkmarkLayer.strokeEnd = 1.0
        checkmarkLayer.add(greenAnimation, forKey: "strokeAnimation")
    }

    private func checkedWithoutAnim() {
        checkmarkLayer.strokeEnd = 1.0
        checkmarkLayer.removeAllAnimations()
    }

    private func uncheckedWithAnim() {
        let revAnimation = createAnimation()
        revAnimation.fromValue = checkmarkLayer.presentation()?.strokeEnd
        revAnimation.toValue = 0.0

        checkmarkLayer.removeAllAnimations()
        checkmarkLayer.strokeEnd = 0.0
        checkmarkLayer.add(revAnimation, forKey: "strokeAnimation")
    }

    private func uncheckedWithoutAnim() {
        checkmarkLayer.strokeEnd = 0.0
        checkmarkLayer.removeAllAnimations()
    }

    private func createAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 0.25
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = true
        return animation
    }
}

