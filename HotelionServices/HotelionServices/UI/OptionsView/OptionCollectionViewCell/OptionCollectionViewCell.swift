//
//  OptionCollectionViewCell.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 18.11.2020.
//

import UIKit

final class OptionCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    @IBOutlet private weak var bgView: UIView!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var removeButton: UIButton!
    @IBOutlet private weak var stackRightCnstr: NSLayoutConstraint!

    var removeButtonIsHidden: Bool = false {
        didSet {
            removeButton.isHidden = removeButtonIsHidden
            stackRightCnstr.constant = removeButtonIsHidden ? 16 : 0
        }
    }

    var option: OptionModel? {
        didSet {
            if let option = option {
                titleLabel.text = option.title
                updateColors()
            }
        }
    }

    var isSelectedItem: Bool = false {
        didSet {
            updateColors()
        }
    }

    var index: Int {
        set { removeButton.tag = newValue }
        get { removeButton.tag }
    }

    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()

        layer.cornerRadius = 16
        layer.masksToBounds = true

        bgView.layer.cornerRadius = layer.cornerRadius
        bgView.layer.borderWidth = 1

        let removeImg = UIImage(named: "icRemoveWhite", in: Bundle.services, compatibleWith: nil)
        removeButton.setImage(removeImg, for: .normal)
    }

    // MARK: - Public methods
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: stackView.center.x - 10, y: stackView.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: stackView.center.x + 10, y: stackView.center.y))

        stackView.layer.add(animation, forKey: "position")
    }

    func updateColors() {
        bgView.backgroundColor = isSelectedItem ? option?.color : .white
        bgView.layer.borderColor = isSelectedItem ? UIColor.clear.cgColor : UIColor.kSeparatorGray.cgColor
        titleLabel.textColor = isSelectedItem ? .white  : .black
    }

    func addRemoveButtonTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        removeButton.addTarget(target, action: action, for: controlEvents)
    }
}
