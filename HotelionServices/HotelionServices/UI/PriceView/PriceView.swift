//
//  PriceView.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 18.11.2020.
//

import UIKit
import HotelionCommon
import RxSwift
import RxCocoa

protocol PriceViewDelegate: class {
    func didTapOrder(in view: PriceView)
}

final class PriceView: BaseCustomView {
    // MARK: - Properties
    @IBOutlet private var xibView: UIView!
    @IBOutlet private var topContainerView: UIView!
    @IBOutlet private var stackView: UIStackView!
    @IBOutlet private var totalPriceTitleLabel: UILabel!
    @IBOutlet private var totalPriceLabel: UILabel!
    @IBOutlet private var orderButton: UIButton!

    private var priceObservable: Observable<String>?

    // Delegate
    weak var delegate: PriceViewDelegate?

    // DisposeBag
    let disposeBag = DisposeBag()

    // MARK: - initialize
    override func initialize() {
        addSelfNibUsingConstraints(bundle: Bundle.services)
        setupUI()
    }
}

// MARK: - Bind
extension PriceView {
    func bind(priceObservable: Observable<String>) {
        self.priceObservable = priceObservable

        self.priceObservable?
            .bind(to: totalPriceLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

// MARK: - UI
private extension PriceView {
    func setupUI() {
        totalPriceTitleLabel.font = UIFont.kDescriptionText
        totalPriceTitleLabel.textColor = .black
        totalPriceTitleLabel.text = "Total price:"

        totalPriceLabel.font = UIFont.kBigTitleText
        totalPriceLabel.textColor = .kViolet

        orderButton.backgroundColor = .kViolet
        orderButton.layer.cornerRadius = 6
        orderButton.layer.masksToBounds = true
        orderButton.setTitle("Order", for: .normal)
        orderButton.setTitleColor(.white, for: .normal)

        addTopShadow()
    }
}

// MARK: - Actions
private extension PriceView {
    @IBAction func orderAction(_ sender: Any) {
        delegate?.didTapOrder(in: self)
    }
}
