//
//  CalendarView.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 24.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit

public final class CalendarView: NibLoadableView, CalendarViewModelOutput {
    // MARK: - Properties
    var viewModel: CalendarViewModelProtocol!

    @IBOutlet private var containerView: UIView!
    @IBOutlet private var monthContainerView: UIView!
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var weekDayLabels: [UILabel]!

    // MARK: - Inits
    override func initialize() {
        setupUI()
    }

    // MARK: - Methods
    public func reloadData() {
        collectionView.reloadData()
    }
}

// MARK: - UI
private extension CalendarView {
    func setupUI() {
        collectionView.register(cell: CalendarItemView.self)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource
extension CalendarView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemsCount()
    }

    public func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CalendarItemView = collectionView.dequeueReusableCellWithIndexPath(indexPath)
        let itemViewModel = viewModel.itemViewModel(for: indexPath.item)
        cell.fill(viewModel: itemViewModel)

        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CalendarView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard viewModel.isAvailableItemViewModel(by: indexPath.item) else { return }
        presentAlert(by: indexPath)
    }

    public func presentAlert(by indexPath: IndexPath) {
        let datePicker = UIDatePicker()
        datePicker.date = viewModel.hour(for: indexPath)
        datePicker.locale = viewModel.getLocale()
        datePicker.datePickerMode = .time
        datePicker.heightAnchor.constraint(equalToConstant: 32).isActive = true

        let cancelAction = AlertViewAction(style: .cancel)
        let doneAction = AlertViewAction(title: "Add", style: .done) {
            self.viewModel.setEvent(by: indexPath, date: datePicker.date)
        }
        let alertVC = AlertViewController(
            title: "Set time",
            contentView: datePicker,
            actions: [cancelAction, doneAction])
        alertVC.present()
    }

    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.2) {
            cell?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.2) {
            cell?.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CalendarView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewItemWidth(),
                      height: collectionViewItemHeight())
    }

    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CalendarView.Constants.sectionTopInset,
                            left: CalendarView.Constants.sectionSideInset,
                            bottom: CalendarView.Constants.sectionSideInset,
                            right: CalendarView.Constants.sectionSideInset)
    }

    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CalendarView.Constants.interitemSpace
    }

    private func collectionViewItemWidth() -> CGFloat {
        let generalSpacing = CalendarView.Constants.sectionSideInset * 2 +
            (CalendarView.Constants.interitemSpace * (CGFloat(CalendarView.Constants.columnsCount) - 1))
        return (frame.size.width - generalSpacing) / CGFloat(CalendarView.Constants.columnsCount)
    }

    private func collectionViewItemHeight() -> CGFloat {
        return CalendarView.Constants.cellHeight
    }
}

// MARK: - Constants
private extension CalendarView {
    enum Constants {
        static let interitemSpace: CGFloat = 12
        static let sectionTopInset: CGFloat = 44
        static let sectionSideInset: CGFloat = 8
        static let columnsCount = 7
        static let cellHeight: CGFloat = 64
    }
}
