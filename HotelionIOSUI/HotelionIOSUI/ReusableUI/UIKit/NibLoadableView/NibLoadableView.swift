//
//  NibLoadableView.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 26.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

import UIKit

public class NibLoadableView: UIView {
    // MARK: - Inits
    public override init(frame: CGRect) {
        super.init(frame: frame)

        loadContentView()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        loadContentView()
    }

    private func loadContentView() {
        addSelfNibUsingConstraints()
        initialize()
    }

    func initialize() {}
}
