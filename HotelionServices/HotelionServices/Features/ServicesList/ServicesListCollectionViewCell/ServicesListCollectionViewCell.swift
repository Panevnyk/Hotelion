//
//  ServicesListTableViewCell.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 13.11.2020.
//

import UIKit
import HotelionCommon

final class ServicesListCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    @IBOutlet private var stackView: UIStackView!
    @IBOutlet private var groupImage: UIImageView!
    @IBOutlet private var titleLabel: UILabel!

    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.kSeparatorGray.cgColor
        layer.masksToBounds = true
        backgroundColor = .white

        titleLabel.textColor = .black
        titleLabel.font = UIFont.kTitleText
    }

    // MARK: - Fill
    func fill(viewModel: ServicesGroupItemViewModelProtocol) {
        titleLabel.text = viewModel.name
        groupImage.image = UIImage(named: viewModel.img, in: Bundle.services, compatibleWith: nil)
    }
}
