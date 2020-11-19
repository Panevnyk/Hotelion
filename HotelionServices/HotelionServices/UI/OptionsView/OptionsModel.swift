//
//  OptionsModel.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 18.11.2020.
//

import UIKit

public final class OptionModel {
    // MARK: - Properties
    public let id: String
    public let title: String
    public let color: UIColor

    public var enable = true
    public var active = false
    public var disableColor: UIColor {
        set { disable = id.isEmpty ? .white : newValue }
        get { disable }
    }
    private var disable: UIColor = .gray

    // MARK: - Init
    public init(id: String,
                title: String,
                color: UIColor = .kViolet) {
        self.id = id
        self.title = title
        self.color = color
    }
}
