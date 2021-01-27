//
//  ProfileHeaderView.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 30.11.2020.
//

import UIKit
import HotelionCommon

final class ProfileCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    @IBOutlet private var conteinerView: UIView!
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var livingDetailsLabel: UILabel!

    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        avatarImageView.layer.cornerRadius = 25.5
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.borderColor = UIColor.kSeparatorGray.cgColor
        avatarImageView.layer.masksToBounds = true

        nameLabel.textColor = .black
        nameLabel.font = UIFont.kBigTitleText

        livingDetailsLabel.textColor = .black
        livingDetailsLabel.font = UIFont.kPlainText
    }

    // MARK: - Fill
    func fill(viewModel: ProfileCollectionViewModelProtocol) {
        nameLabel.text = viewModel.name
        livingDetailsLabel.text = viewModel.livingDetails
        avatarImageView.image = UIImage(named: "icPlaceholderUser", in: Bundle.services, compatibleWith: nil)
    }
}
