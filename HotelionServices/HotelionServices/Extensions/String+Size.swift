//
//  NSAttributedString_Size.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 17.11.2020.
//

import UIKit

extension String {
    func size(maxWidth: CGFloat, font: UIFont) -> CGSize {
        let estimatedHeight = height(forConstrainedWidth: maxWidth, font: font)
        let estimatedWidth = width(usingFont: font)

        let finalHeight = estimatedHeight.rounded(.up)
        let finalWidth = estimatedWidth > maxWidth ? maxWidth : estimatedWidth.rounded(.up)

        return CGSize(width: finalWidth, height: finalHeight)
    }

    func size(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size
    }

    func width(usingFont font: UIFont) -> CGFloat {
        return size(usingFont: font).width
    }

    func height(usingFont font: UIFont) -> CGFloat {
        return size(usingFont: font).height
    }
}
