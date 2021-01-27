//
//  TitleWithValidCheckerView.swift
//  HotelionFastCheckIn
//
//  Created by Vladyslav Panevnyk on 15.01.2021.
//

import UIKit
import RxSwift
import RxCocoa
import HotelionCommon

final class TitleWithValidCheckerView: BaseCustomView {
    // MARK: - Properties
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var validationImageContainerView: UIView!
    @IBOutlet private var validationImageView: UIImageView!

    var isValid = BehaviorRelay<Bool>(value: false)
    private let disposeBag = DisposeBag()

    // MARK: - initialize
    override func initialize() {
        super.initialize()

        addSelfNibUsingConstraints(bundle: Bundle.fastCheckIn)
        setupUI()
        bindUI()
    }

    private func setupUI() {
        titleLabel.textColor = UIColor.kTextMiddleGray
        titleLabel.font = UIFont.kPlainText

        validationImageContainerView.layer.cornerRadius = 11
        validationImageContainerView.layer.masksToBounds = true
        validationImageContainerView.backgroundColor = .kGreen
    }

    private func bindUI() {
        isValid
            .subscribe { (value) in
                self.validationImageContainerView.isHidden = !value
            }.disposed(by: disposeBag)
    }

    // MARK: - Public methods
    func fill(text: String) {
        titleLabel.text = text
    }
}
