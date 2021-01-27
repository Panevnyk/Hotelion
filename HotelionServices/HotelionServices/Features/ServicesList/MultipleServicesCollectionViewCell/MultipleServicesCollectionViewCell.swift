//
//  MultipleServicesCollectionViewCell.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 02.12.2020.
//

import UIKit
import HotelionCommon

protocol MultipleServicesCollectionViewCellDelegate: class {
    func didTapDoNotDisturb(in view: MultipleServicesCollectionViewCell)
    func didTapCalling(in view: MultipleServicesCollectionViewCell)
    func didTapMessage(in view: MultipleServicesCollectionViewCell)
}

final class MultipleServicesCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    // UI
    @IBOutlet private var doNotDisturbContainerView: BaseTapableView!
    @IBOutlet private var doNotDisturbImageView: UIImageView!
    @IBOutlet private var doNotDisturbLabel: UILabel!

    @IBOutlet private var callingContainerView: BaseTapableView!
    @IBOutlet private var callingImageView: UIImageView!

    @IBOutlet private var messageContainerView: BaseTapableView!
    @IBOutlet private var messageImageView: UIImageView!

    // Delegate
    weak var delegate: MultipleServicesCollectionViewCellDelegate?

    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        doNotDisturbContainerView.layer.cornerRadius = 16
        doNotDisturbContainerView.layer.masksToBounds = true
        doNotDisturbContainerView.layer.borderWidth = 1
        doNotDisturbContainerView.layer.borderColor = UIColor.kSeparatorGray.cgColor
        doNotDisturbContainerView.delegate = self

        doNotDisturbLabel.font = .kTitleText
        doNotDisturbLabel.textColor = .black
        doNotDisturbLabel.text = "Do Not\nDisturb Off"

        callingContainerView.layer.cornerRadius = 16
        callingContainerView.layer.masksToBounds = true
        callingContainerView.layer.borderWidth = 1
        callingContainerView.layer.borderColor = UIColor.kSeparatorGray.cgColor
        callingContainerView.delegate = self

        messageContainerView.layer.cornerRadius = 16
        messageContainerView.layer.masksToBounds = true
        messageContainerView.layer.borderWidth = 1
        messageContainerView.layer.borderColor = UIColor.kSeparatorGray.cgColor
        messageContainerView.delegate = self
    }
}

// MARK: - BaseTapableViewDelegate
extension MultipleServicesCollectionViewCell: BaseTapableViewDelegate {
    func didTapAction(inView view: BaseTapableView) {
        switch view {
        case doNotDisturbContainerView:
            delegate?.didTapDoNotDisturb(in: self)
        case callingContainerView:
            delegate?.didTapCalling(in: self)
        case messageContainerView:
            delegate?.didTapMessage(in: self)
        default:
            break
        }
    }
}
