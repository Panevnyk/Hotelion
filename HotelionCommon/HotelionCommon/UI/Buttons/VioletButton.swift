//
//  VioletButton.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 11.11.2020.
//

import UIKit

public class VioletButton: StateBackgroundColorButton {
    /// Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)

        initCustomize()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        initCustomize()
    }

    /// Customize
    private func initCustomize() {
        layer.cornerRadius = 4
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        backgroundColor = UIColor.kViolet
        backgroundDisabledColor = UIColor.kNotActiveViolet
        setTitleColor(UIColor.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
    }

    public func setBorder(_ color: UIColor) {
        layer.borderWidth = 1
        layer.borderColor = color.cgColor
    }
}

