//
//  HotelCollectionViewCell.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 16.11.2020.
//

import UIKit
import HotelionCommon

final class HotelCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    @IBOutlet private var imageContentView: UIView!
    @IBOutlet private var hotelImageView: UIImageView!
    @IBOutlet private var titleContentView: UIView!
    @IBOutlet private var hotelTitle: UILabel!

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

        imageContentView.backgroundColor = .kViolet

        hotelTitle.textColor = .white
        hotelTitle.font = UIFont.kTitleText
    }

    func fill(viewModel: HotelCollectionViewModel) {
        hotelTitle.text = viewModel.title
        hotelImageView.image = UIImage(named: "icSPAResort", in: Bundle.services, compatibleWith: nil)
    }

    func setImageFrame(frame: CGRect) {
        widthAnchor.constraint(equalToConstant: frame.width).isActive = true
    }

    // MARK: - Fill
    func fill() {}
}
