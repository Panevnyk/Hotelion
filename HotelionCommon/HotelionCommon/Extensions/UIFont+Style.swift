//
//  UIFont+Style.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 25.11.2020.
//

import UIKit

public extension UIFont {
    @nonobjc class var kPlainText: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    @nonobjc class var kTitleText: UIFont {
        return UIFont.systemFont(ofSize: 15, weight: .medium)
    }

    @nonobjc class var kSectionHeaderText: UIFont {
        return UIFont.systemFont(ofSize: 18, weight: .semibold)
    }

    @nonobjc class var kBigTitleText: UIFont {
        return UIFont.systemFont(ofSize: 22, weight: .semibold)
    }

    @nonobjc class var kDescriptionText: UIFont {
        return UIFont.systemFont(ofSize: 13, weight: .regular)
    }
}
