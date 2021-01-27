//
//  StepView.swift
//  HotelionFastCheckIn
//
//  Created by Vladyslav Panevnyk on 13.01.2021.
//

import UIKit
import HotelionCommon

final class StepView: BaseCustomView {
    // MARK: - Properties
    @IBOutlet private var xibView: UIView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var contentStackView: UIStackView!

    // MARK: - initialize
    override func initialize() {
        super.initialize()

        addSelfNibUsingConstraints(bundle: Bundle.fastCheckIn)
        setupUI()
    }

    private func setupUI() {
        titleLabel.font = UIFont.kSectionHeaderText
        titleLabel.textColor = .kViolet
    }

    func fill(countOfSteps: Int, currentStep: Int) {
        contentStackView.arrangedSubviews.forEach {
            contentStackView.removeArrangedSubview($0)
        }

        titleLabel.text = "Step " + String(currentStep) + "/" + String(countOfSteps)

        for i in 1 ... countOfSteps {
            let view = UIView(frame: .zero)
            view.backgroundColor = i <= currentStep
                ? UIColor.kViolet : UIColor.kNotActiveViolet
            view.layer.cornerRadius = 4
            view.layer.masksToBounds = true
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: 8).isActive = true
            view.widthAnchor.constraint(equalToConstant: 28).isActive = true

            contentStackView.addArrangedSubview(view)
        }
    }
}
