//
//  ServicesListHeaderReusableView.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 16.11.2020.
//

import UIKit

public final class ServicesListHeaderReusableView: UICollectionReusableView {
    // MARK: - Properties
    @IBOutlet private var titleLabel: UILabel!

    // MARK: - awakeFromNib
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        titleLabel.textColor = .black
        titleLabel.font = UIFont.kSectionHeaderText
    }

    // MARK: - Fill
    func fill(text: String) {
        titleLabel.text = text
    }
}
