//
//  OptionsView.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 18.11.2020.
//

import UIKit

protocol OptionsViewDelegate: class {
    func optionsView(_ optionsView: OptionsView, removeTasteAt index: Int)
    func getScreenRootView() -> UIView
    func didSelectOption(_ optionsView: OptionsView, byItem item: Int)
}

enum OptionsViewMode {
    case editable
    case singleSelectable
    case readonly
}

final class OptionsView: UIView {
    // MARK: - Properties
    private var collectionView: OptionsCollectionView!
    private var heightConstraint = NSLayoutConstraint()

    private var optionsList: [OptionModel] = []
    private var selectedIndex = 0
    weak var delegate: OptionsViewDelegate?

    var mode: OptionsViewMode = .singleSelectable

    var collectionViewBackgroundColor: UIColor = .white {
        didSet {
            collectionView.backgroundColor = collectionViewBackgroundColor
        }
    }

    var options: [OptionModel] {
        set {
            optionsList = newValue
            updateCollectionViewLayout()
            layoutIfNeeded()
        }
        get { optionsList }
    }

    // MARK: - inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize() 
    }

    private func initialize() {
        let cellSize = CGSize(width: 80.0, height: 32.0)
        let layout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        layout.itemSize = cellSize
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 8.0
        layout.estimatedItemSize = CGSize(width: 64.0, height: 32.0)

        collectionView = OptionsCollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cell: OptionCollectionViewCell.self, bundle: Bundle.services)
        addSubviewUsingConstraints(view: collectionView)
    }

    func updateCollectionViewLayout() {
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.layoutIfNeeded()
        collectionView.heightAnchor.constraint(equalToConstant: collectionView.contentSize.height).isActive = true
    }

    func addOption(_ option: OptionModel) {
        for (index, element) in self.optionsList.enumerated() where element.id == option.id {
            if let cell = self.collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? OptionCollectionViewCell {
                cell.shake()
            }
        }
        let filtered = optionsList.filter { $0.id == option.id }

        guard filtered.count == 0 else { return }

        if optionsList.count < 5 {
            optionsList.append(option)
            collectionView.insertItems(at: [IndexPath(item: optionsList.count - 1, section: 0)])
        }
    }
}

// MARK: - Actions
private extension OptionsView {
    @objc func removeButtonAction(_ sender: UIButton) {
        isUserInteractionEnabled = false
        optionsList.remove(at: sender.tag)
        delegate?.optionsView(self, removeTasteAt: sender.tag)
        collectionView.deleteItems(at: [IndexPath(item: sender.tag, section: 0)])

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.updateCollectionViewLayout()

            UIView.animate(withDuration: 0.2) {
                self.delegate?.getScreenRootView().layoutIfNeeded()
            }
            self.isUserInteractionEnabled = true
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension OptionsView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return optionsList.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: OptionCollectionViewCell = collectionView.dequeueReusableCellWithIndexPath(indexPath)
        cell.index = indexPath.item
        cell.option = optionsList[indexPath.item]
        cell.isSelectedItem = selectedIndex == indexPath.item
        cell.removeButtonIsHidden = mode != .editable
        cell.addRemoveButtonTarget(self, action: #selector(removeButtonAction(_:)), for: .touchUpInside)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard mode == .singleSelectable else { return }

        selectedIndex = indexPath.item
        collectionView.reloadData()
        delegate?.didSelectOption(self, byItem: selectedIndex)
    }
}

final class OptionsCollectionView: UICollectionView {
    // MARK: - Inits
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if !bounds.size.equalTo(intrinsicContentSize) {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        get { contentSize }
    }

    // MARK: - setup
    func setup() {
        isScrollEnabled = false
        bounces = false
    }
}
