//
//  OrderStatusView.swift
//  HotelionOrders
//
//  Created by Vladyslav Panevnyk on 02.12.2020.
//

import UIKit
import HotelionCommon

final class OrderStatusView: BaseCustomView {
    // MARK: - Properties
    @IBOutlet private var xibView: UIView!
    @IBOutlet private var statusLabel: UILabel!

    // MARK: - initialize
    override func initialize() {
        super.initialize()
        addSelfNibUsingConstraints(bundle: Bundle.orders)
        setupUI()
    }

    private func setupUI() {
        layer.cornerRadius = 6
        layer.masksToBounds = true

        statusLabel?.font = UIFont.kDescriptionText
        statusLabel?.textColor = .white
    }

    // MARK: - Public methods
    func fill(bookingStatus: BookingStatus) {
        statusLabel.text = bookingStatus.title
        xibView.backgroundColor = bookingStatus.color
    }
}
