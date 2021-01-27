//
//  DigitalSignatureViewModel.swift
//  HotelionFastCheckIn
//
//  Created by Vladyslav Panevnyk on 14.01.2021.
//

import UIKit
import RxSwift
import RxCocoa

public protocol DigitalSignatureViewModelProtocol {
    var isSignatureDraw: BehaviorRelay<Bool> { get }
    var isValid: Observable<Bool> { get }

    func makeSignature(from image: UIImage) -> String
}

public final class DigitalSignatureViewModel: DigitalSignatureViewModelProtocol {
    // MARK: - Properties
    public var isSignatureDraw = BehaviorRelay<Bool>(value: false)

    public var isValid: Observable<Bool> {
        return isSignatureDraw.asObservable()
    }

    // MARK: - Inits
    public init() {}

    // MARK: - Methods
    public func makeSignature(from image: UIImage) -> String {
        return image.scaledToBase64()
    }
}
