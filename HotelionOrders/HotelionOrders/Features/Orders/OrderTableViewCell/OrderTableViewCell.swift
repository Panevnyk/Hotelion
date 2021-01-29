//
//  OrderTableViewCell.swift
//  HotelionOrders
//
//  Created by Vladyslav Panevnyk on 01.12.2020.
//

import UIKit
import HotelionCommon

protocol OrderTableViewCellDelegate: class {
    func didDeleteItem(cell: OrderTableViewCell)
}

final class OrderTableViewCell: UITableViewCell {
    // MARK: - Properties
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var orderImageView: UIImageView!
    @IBOutlet private var orderTitleLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var deleteButton: UIButton!
    @IBOutlet private var orderStatusView: OrderStatusView!
    @IBOutlet private var payNowButton: VioletButton!
    @IBOutlet private var deliveryStatusLabel: UILabel!
    @IBOutlet private var deliveryDateLabel: UILabel!

    weak var delegate: OrderTableViewCellDelegate?

    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Setup UI
    private func setupUI() {
        containerView.layer.cornerRadius = 16
        containerView.layer.masksToBounds = true
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.kSeparatorGray.cgColor

        orderImageView.layer.cornerRadius = 6
        orderImageView.layer.masksToBounds = true

        orderTitleLabel.textColor = .black
        orderTitleLabel.font = UIFont.kTitleText

        deliveryStatusLabel.textColor = .kGrayText
        deliveryStatusLabel.font = UIFont.kDescriptionText

        deliveryDateLabel.textColor = .kGrayText
        deliveryDateLabel.font = UIFont.kDescriptionText

        payNowButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }

    // MARK: - Public methods
    func fill(viewModel: OrderViewModelProtocol) {
        orderTitleLabel.text = viewModel.name
        priceLabel.attributedText = makePriceAttributedText(from: viewModel)
        orderImageView.image = UIImage(named: "icHotelPlaceholderSmall", in: Bundle.orders, compatibleWith: nil)
        deliveryStatusLabel.text = viewModel.deliveryDescription
        deliveryDateLabel.text = viewModel.deliveryDate
        orderStatusView.fill(orderStatus: viewModel.orderStatus)
        deleteButton.isHidden = !viewModel.orderStatus.isRemovable
    }

    private func makePriceAttributedText(from viewModel: OrderViewModelProtocol) -> NSAttributedString {
        let sentence = viewModel.price + " " + viewModel.currency
        let priceAttributes = [NSAttributedString.Key.font: UIFont.kBigTitleText,
                               NSAttributedString.Key.foregroundColor: UIColor.kViolet]
        let currencyAttributes = [NSAttributedString.Key.font: UIFont.kTitleText,
                                  NSAttributedString.Key.foregroundColor: UIColor.kViolet]
        let attributedSentence = NSMutableAttributedString(string: sentence, attributes: priceAttributes)

        let range = NSRange(location: viewModel.price.count + 1,
                            length: viewModel.currency.count)
        attributedSentence.setAttributes(currencyAttributes, range: range)

        return attributedSentence
    }
}

// MARK: - Actions
private extension OrderTableViewCell {
    @IBAction func payNowAction(_ sender: Any) {
    }

    @IBAction func deleteAction(_ sender: Any) {
        delegate?.didDeleteItem(cell: self)
    }
}
