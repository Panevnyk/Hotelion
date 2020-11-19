//
//  DetailsHeaderView.swift
//  Hotelion
//
//  Created by Bodia Kovbas on 4/10/20.
//  Copyright © 2020 Panevnyk Vlad. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import HotelionCommon

enum HeaderState {
    case navBar
    case header
    
    var isNavBar: Bool {
        return self == .navBar
    }
}

protocol DetailsHeaderViewDelegate: class {
    func backAction(inView view: DetailsHeaderView)
    func didChangeState(_ state: HeaderState, inView view: DetailsHeaderView)
}

extension DetailsHeaderViewDelegate {
    func didTapFlag(_ isFlaged: Bool, inView view: DetailsHeaderView) {}
}

final class DetailsHeaderView: BaseCustomView {
    // MARK: - Properties
    // UI
    @IBOutlet private var shadowView: UIView!
    @IBOutlet private var btnBack: UIButton!
    @IBOutlet private var lbTitle: UILabel!
    @IBOutlet private var bigTitleLabel: UILabel!
    @IBOutlet private var imagesStackView: UIStackView!
    
    private var pageIndicator = UIPageControl()
    private var separatorView = UIView()
    
    // Layers
    private var maskLayer = CAShapeLayer()
    private var shadowLayer = CAGradientLayer()
    
    // Cnstr
    @IBOutlet private var cnstrHeight: NSLayoutConstraint!
    @IBOutlet private var cnstrBtnBackTop: NSLayoutConstraint!
    
    // Models
    let navBarHeight = 52 + UIApplication.shared.statusBarFrame.height
    
    // Delegate
    weak var delegate: DetailsHeaderViewDelegate?
    
    // Constants
    private static let magicK: CGFloat = 4.0 / 3.0 * (sqrt(2.0) - 1.0)
    private static let cornerRadius: CGFloat = 8
    
    // DisposeBag
    let disposeBag = DisposeBag()
    
    // Models
    var state = HeaderState.header {
        didSet {
            guard state != oldValue else {
                return
            }
            updateOfState()
        }
    }

    // MARK: - initialize
    override func initialize() {
        super.initialize()
        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        cutBottom()
    }
}

// MARK: - Public methods
extension DetailsHeaderView {
    func updateByScrollView(_ scrollView: UIScrollView) {
        let headerHeight = max(navBarHeight, 280 - scrollView.contentOffset.y)
        
        cnstrHeight.constant = headerHeight
        state = headerHeight <= navBarHeight ? .navBar : .header
    }
}

// MARK: - Change by nav bar state
private extension DetailsHeaderView {
    func updateOfState() {
        if state.isNavBar {
            shadowLayer.removeFromSuperlayer()
        } else {
            shadowView.layer.addSublayer(shadowLayer)
        }
        updateAnimation(headerState: state)
        
        delegate?.didChangeState(state, inView: self)
    }
    
    func updateAnimation(headerState: HeaderState) {
        let showBigHeaderAlpha: CGFloat = headerState.isNavBar ? 0 : 1
        let showNavBarAlpha: CGFloat = headerState.isNavBar ? 1 : 0

        UIView.animate(withDuration: 0.2) {
            self.shadowView.backgroundColor = headerState.isNavBar ? .white : .clear
            self.bigTitleLabel.alpha = showBigHeaderAlpha
            self.pageIndicator.alpha = showBigHeaderAlpha
            self.separatorView.alpha = showNavBarAlpha
            self.lbTitle.alpha = showNavBarAlpha
            self.btnBack.tintColor = headerState.isNavBar ? .black : .white
        }
    }
}

// MARK: - Title
extension DetailsHeaderView {
    func setTitle(_ text: String) {
        lbTitle.text = text
        bigTitleLabel.text = text
    }
}

// MARK: - Images
extension DetailsHeaderView {
    func set(images: [String]?) {
        guard let images = images else {
            return
        }
        
        images.forEach { (imageName) in
            let imvAvatar = UIImageView()
            imvAvatar.contentMode = .scaleAspectFill
            imvAvatar.clipsToBounds = true
            let img = UIImage(named: imageName, in: Bundle.services, compatibleWith: nil)
            imvAvatar.image = img
            imagesStackView.addArrangedSubview(imvAvatar)
            imvAvatar.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        }
        
        pageIndicator.numberOfPages = images.count
        pageIndicator.isHidden = images.count < 2
    }
    
    func setupImages(_ images: [String]) {
        guard images.count != imagesStackView.subviews.count else {
            return
        }
        
        imagesStackView.removeAllSubviews()
        
        guard images.count > 0 else {
            let imvAvatar = UIImageView(image: #imageLiteral(resourceName: "cafe_house_placeholder"))
            imvAvatar.contentMode = .scaleAspectFill
            imagesStackView.addArrangedSubview(imvAvatar)
            return
        }
        
        for imageUrl in images {
            let img = UIImage(named: "TODO", in: Bundle.services, compatibleWith: nil)
            let imvAvatar = UIImageView(image: img)
            imvAvatar.contentMode = .scaleAspectFill
            imvAvatar.clipsToBounds = true
//            imvAvatar.sd_setImage(urlString: imageUrl,
//                                  placeholder: #imageLiteral(resourceName: "cafe_house_placeholder"),
//                                  prefferedSize: CGSize.init(width: UIScreen.main.bounds.width,
//                                                             height: UIScreen.main.bounds.width))
            imagesStackView.addArrangedSubview(imvAvatar)
            imvAvatar.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        }
        
        pageIndicator.numberOfPages = images.count
        pageIndicator.isHidden = images.count < 2
    }
}

// MARK: - UI
private extension DetailsHeaderView {
    func setupUI() {
        addSelfNibUsingConstraints(bundle: Bundle.services)

        cnstrBtnBackTop.constant = UIApplication.shared.statusBarFrame.height

        let backImage = UIImage(named: "icArrowLeftWhite", in: Bundle.services, compatibleWith: nil)?
            .withRenderingMode(.alwaysTemplate)
        btnBack.setImage(backImage, for: .normal)
        btnBack.tintColor = .black

        lbTitle.font = UIFont(name: "AvenirNextW1G-Heavy", size: 20)
        lbTitle.textColor = UIColor.black

        bigTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        bigTitleLabel.textColor = .white

        pageIndicator.translatesAutoresizingMaskIntoConstraints = false
        pageIndicator.currentPage = 0
        addSubview(pageIndicator)
        
        NSLayoutConstraint.activate([
            pageIndicator.bottomAnchor.constraint(equalTo: imagesStackView.bottomAnchor,
                                                  constant: -12),
            pageIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])

        layer.mask = maskLayer

        shadowLayer.frame = CGRect(x: 0,
                                   y: 0,
                                   width: UIScreen.main.bounds.width,
                                   height: 44 + UIApplication.shared.statusBarFrame.height)
        shadowLayer.colors = [
            UIColor(white: 0, alpha: 0.66).cgColor,
            UIColor(white: 0, alpha: 0.33).cgColor,
            UIColor(white: 1, alpha: 0)
        ]
        shadowLayer.startPoint = .zero
        shadowLayer.endPoint = .init(x: 0, y: 1)
        shadowView.layer.addSublayer(shadowLayer)
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = UIColor.init(white: 224 / 255.0, alpha: 1)
        addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            separatorView.leftAnchor.constraint(equalTo: leftAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -DetailsHeaderView.cornerRadius),
            separatorView.rightAnchor.constraint(equalTo: rightAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5)
            ])
        
        updateOfState()
    }
    
    func cutBottom() {
        // Mask
        let frame = bounds
        let path: UIBezierPath
        
        switch state {
        case .header:
            path = UIBezierPath()
            path.move(to: .zero)
            path.addLine(to: .init(x: frame.maxX,
                                   y: frame.minY))
            path.addLine(to: .init(x: frame.maxX,
                                   y: frame.maxY))
            path.addCurve(to: .init(x: frame.maxX - DetailsHeaderView.cornerRadius,
                                    y: frame.maxY - DetailsHeaderView.cornerRadius),
                          controlPoint1: .init(x: frame.maxX,
                                               y: frame.maxY - DetailsHeaderView.cornerRadius * DetailsHeaderView.magicK),
                          controlPoint2: .init(x: frame.maxX - DetailsHeaderView.cornerRadius + DetailsHeaderView.cornerRadius * DetailsHeaderView.magicK,
                                               y: frame.maxY - DetailsHeaderView.cornerRadius))
            path.addLine(to: .init(x: DetailsHeaderView.cornerRadius,
                                   y: frame.maxY - DetailsHeaderView.cornerRadius))
            path.addCurve(to: .init(x: frame.minX,
                                    y: frame.maxY),
                          controlPoint1: .init(x: DetailsHeaderView.cornerRadius - DetailsHeaderView.cornerRadius * DetailsHeaderView.magicK,
                                               y: frame.maxY - DetailsHeaderView.cornerRadius),
                          controlPoint2: .init(x: 0,
                                               y: frame.maxY - DetailsHeaderView.cornerRadius * DetailsHeaderView.magicK))
            path.addLine(to: .zero)
            
        case .navBar:
            path = UIBezierPath(rect: frame.divided(atDistance: DetailsHeaderView.cornerRadius,
                                                    from: CGRectEdge.maxYEdge).remainder)
        }
        
        maskLayer.path = path.cgPath
    }
}

// MARK: - Actions
private extension DetailsHeaderView {
    @IBAction func backAction(_ sender: Any) {
        delegate?.backAction(inView: self)
    }
}

// MARK: - UIScrollViewDelegate
extension DetailsHeaderView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentItem = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageIndicator.currentPage = Int(currentItem)
    }
}
