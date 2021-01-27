//
//  UIImage+Base64.swift
//  HotelionFastCheckIn
//
//  Created by Vladyslav Panevnyk on 22.01.2021.
//

import UIKit

extension UIImage {
    func scaledToBase64(_ newHeight: CGFloat) -> String {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale

        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))

        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        let scaled = newImage?.pngData()

        UIGraphicsEndImageContext()

        guard let pngData = scaled else {
            print("!!! FAIL: scaledToBase64 !!!")
            return ""
        }

        return pngData.toBase64()
    }

    func scaledToBase64() -> String {
        guard let pngData = pngData() else {
            print("!!! FAIL: scaledToBase64 !!!")
            return ""
        }

        return pngData.toBase64()

    }
}

extension Data {
    func toBase64() -> String {
        return self.base64EncodedString(options: .lineLength64Characters);
    }
}

extension String {
    func fromBase64ToUIImage() -> UIImage? {
        if let imageData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) {
            return UIImage(data: imageData)
        }

        return nil
    }

    func toBase64() -> String {
        guard let data = self.data(using: String.Encoding.utf8) else { return "" }
        return data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }
}
