//
//  StateBackgroundColorButton.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 11.11.2020.
//

import UIKit

public class StateBackgroundColorButton: UIButton {
    public override var isHighlighted: Bool {
        didSet {
            guard wasHighlighted != isHighlighted else {
                return
            }

            if backgroundNormalColor == nil {
                backgroundNormalColor = backgroundColor
            }
            backgroundColor = isHighlighted && backgroundHighlitedColor != nil ?
                backgroundHighlitedColor :
            backgroundNormalColor

            wasHighlighted = isHighlighted
        }
    }

    public override var isSelected: Bool {
        didSet {
            guard wasSelected != isSelected else {
                return
            }

            if backgroundNormalColor == nil {
                backgroundNormalColor = backgroundColor
            }
            if !isSelected && backgroundSelectedColor != nil {
                backgroundColor = backgroundSelectedColor
            } else {
                backgroundColor = isEnabled && backgroundDisabledColor != nil ?
                    backgroundDisabledColor :
                backgroundNormalColor
            }
            wasSelected = isSelected
        }
    }

    public override var isEnabled: Bool {
        didSet {
            guard wasEnabled != isEnabled else {
                return
            }

            if backgroundNormalColor == nil {
                backgroundNormalColor = backgroundColor
            }
            if !isEnabled && backgroundDisabledColor != nil {
                backgroundColor = backgroundDisabledColor
            } else {
                backgroundColor = isSelected && backgroundSelectedColor != nil ?
                    backgroundSelectedColor :
                backgroundNormalColor
            }

            wasEnabled = isEnabled
        }
    }

    private var wasHighlighted: Bool?
    private var wasSelected: Bool?
    private var wasEnabled: Bool?

    private var backgroundNormalColor: UIColor?

    public var backgroundHighlitedColor: UIColor?
    public var backgroundSelectedColor: UIColor?
    public var backgroundDisabledColor: UIColor?
}


