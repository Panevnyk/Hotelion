//
//  QRCodeMainView.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 01.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI

struct QRCodeMainView: View {
    var body: some View {
        Image(uiImage: qrCodeImage() ?? UIImage())
    }

    func qrCodeImage() -> UIImage? {
        // Get define string to encode
        let myString = "https://ebay.com"
        // Get data from the string
        let data = myString.data(using: String.Encoding.ascii)
        // Get a QR CIFilter
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        // Input the data
        qrFilter.setValue(data, forKey: "inputMessage")
        // Get the output image
        guard let qrImage = qrFilter.outputImage else { return nil }
        // Scale the image
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledQrImage = qrImage.transformed(by: transform)
        // Do some processing to get the UIImage
        let context = CIContext()
        guard let cgImage = context.createCGImage(scaledQrImage, from: scaledQrImage.extent) else { return nil }
        let processedImage = UIImage(cgImage: cgImage)

        return processedImage
    }
}

struct QRCodeMainView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeMainView()
    }
}
