//
//  ActivityIndicatorView.swift
//  Hotelion
//
//  Created by Panevnyk Vlad on 3/23/20.
//

import UIKit

final class ActivityIndicatorView: UIView, DetailAnimable {

    @IBOutlet private var xibView: UIView!
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var activityIndecator: UIActivityIndicatorView!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        addSelfNibUsingConstraints(bundle: Bundle.common)
        initialize()
    }
    
    func initialize() {
        alpha = 0
        contentView.layer.cornerRadius = 5
        contentView.backgroundColor = UIColor.kTextDarkGray
    }
    
    func show() {
        showView()
        activityIndecator.startAnimating()
    }
    
    func hide() {
        hideView { [weak self] in
            self?.activityIndecator.stopAnimating()
            self?.removeFromSuperview()
        }
    }
    
}
