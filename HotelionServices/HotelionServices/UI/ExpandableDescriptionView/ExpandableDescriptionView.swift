//
//  ExpandableDescriptionView.swift
//  Hotelion
//
//  Created by Panevnyk Vlad on 8/29/20.
//  Copyright © 2020 Panevnyk Vlad. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import HotelionCommon

protocol ExpandableDescriptionViewDelegate: class {
    func getScreenRootView() -> UIView
}

final class ExpandableDescriptionView: BaseCustomView {
    // MARK: - Properties
    // Constants
    private static let minHeightForExpanding: CGFloat = 44
    
    // UI
    @IBOutlet private var xibView: UIView!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var descriptionAlpha0Label: UILabel!
    @IBOutlet private var descriptionHeightView: UIView!
    @IBOutlet private var expandBackgroundView: UIView!
    @IBOutlet private var expandView: BaseSelectableView!
    @IBOutlet private var expandLabel: UILabel!
    @IBOutlet private var expandImageView: UIImageView!
    
    // Cnstr
    @IBOutlet private var cnstrHeightShortDescription: NSLayoutConstraint!
    @IBOutlet private var cnstrHeightExpandView: NSLayoutConstraint!
    @IBOutlet private var cnstrTopExpandView: NSLayoutConstraint!
    
    // Variables
    private var fullDescription = ""
    private var isOpen = false
    private var isExpandable = false
    
    // DisposeBag
    let disposeBag = DisposeBag()

    // Delegate
    weak var delegate: ExpandableDescriptionViewDelegate?

    // MARK: - initialize
    override func initialize() {
        super.initialize()
        addSelfNibUsingConstraints(bundle: Bundle.services)
        setupUI()
    }
}


// MARK: - UI
private extension ExpandableDescriptionView {
    func setupUI() {
        expandView.delegate = self

        backgroundColor = .white

        descriptionLabel.font = UIFont.kDescriptionText
        descriptionLabel.textColor = UIColor.black

        descriptionAlpha0Label.font = UIFont.kDescriptionText
        descriptionAlpha0Label.textColor = UIColor.white

        expandLabel.font = UIFont.kDescriptionText
        expandLabel.textColor = UIColor.kTextDarkGray
    }
}

// MARK: - Bind
extension ExpandableDescriptionView {
    func bind(textObservable: Observable<String>) {
        textObservable
            .subscribe(onNext: { [unowned self] (text) in
                self.fill(text: text)
            })
            .disposed(by: disposeBag)
    }
    
    func fill(text: String) {
        fullDescription = text
        let size = text.size(maxWidth: bounds.size.width, font: descriptionLabel.font)
        isExpandable = size.height > ExpandableDescriptionView.minHeightForExpanding
        descriptionLabel.text = text
        descriptionAlpha0Label.text = text
        
        updateUI()
    }
}

// MARK: - UI
private extension ExpandableDescriptionView {
    func updateUI() {
        let isShowContent = fullDescription.count > 0
        let isShowExpand = isShowContent && isExpandable

        cnstrHeightShortDescription.constant = isShowContent ? ExpandableDescriptionView.minHeightForExpanding : 0
        cnstrTopExpandView.constant = isShowExpand ? 3 : 0
        cnstrHeightExpandView.constant = isShowExpand ? 45 : 0
        
        isHidden = !isShowContent
        expandView.isHidden = !isShowExpand
        expandLabel.isHidden = !isShowExpand
        expandImageView.isHidden = !isShowExpand
        expandBackgroundView.isHidden = !isShowExpand
        
        if isShowContent {
            updateExpandableUI(isShowExpand: isShowExpand)
        }
    }
    
    func updateExpandableUI(isShowExpand: Bool = true) {
        cnstrHeightShortDescription.isActive = !(isOpen || !isShowExpand)

        let imgNamed = isOpen ? "icShowLess" : "icShowMore"
        let img = UIImage(named: imgNamed, in: Bundle.services, compatibleWith: nil)
        expandImageView.image = img
        expandLabel.text = isOpen ? "Show less" : "Show more"
    }
}

// MARK: - BaseTapableViewDelegate
extension ExpandableDescriptionView: BaseTapableViewDelegate {
    func didTapAction(inView view: BaseTapableView) {
        isOpen = !isOpen
        
        updateExpandableUI()
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.delegate?.getScreenRootView().layoutIfNeeded()
        }
    }
}
