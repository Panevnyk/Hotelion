//
//  ServicesListViewController.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 13.11.2020.
//

import UIKit
import HotelionCommon

public protocol ServicesListCoordinatorDelegate: class {
    func didSelectServiceGroup(_ serviceGroup: ServicesGroup)
}

public final class ServicesListViewController: UIViewController {
    // MARK: - Properties
    // UI
    @IBOutlet private var collectionView: UICollectionView!

    // ViewModel
    public var viewModel: ServicesListViewModelProtocol!

    // Delegates
    public var coordinatorDelegate: ServicesListCoordinatorDelegate?

    // MARK: - Life cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - UI
private extension ServicesListViewController {
    func setupUI() {
        view.backgroundColor = .kBackground

        collectionView.register(cell: ServicesListCollectionViewCell.self, bundle: Bundle.services)
        collectionView.register(cell: HotelCollectionViewCell.self, bundle: Bundle.services)
        collectionView.register(cell: ServicesListHeaderReusableView.self, kind: UICollectionView.elementKindSectionHeader, bundle: Bundle.services)
        collectionView.backgroundColor = .kBackground
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource
extension ServicesListViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSection()
    }

    public func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemsCount(in: section)
    }

    public func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let servicesCollectionType = viewModel.servicesCollectionType(by: indexPath.section) else {
            return UICollectionViewCell()
        }

        switch servicesCollectionType {
        case .hotel:
            let cell: HotelCollectionViewCell = collectionView.dequeueReusableCellWithIndexPath(indexPath)
            cell.setImageFrame(frame: CGRect(origin: .zero, size: hotelSectionItemSize()))
            return cell
        case .services:
            let cell: ServicesListCollectionViewCell = collectionView.dequeueReusableCellWithIndexPath(indexPath)
            let itemViewModel = viewModel.servicesGroupViewModel(for: indexPath.item)
            cell.fill(viewModel: itemViewModel)

            return cell
        }
    }

    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let servicesCollectionType = viewModel.servicesCollectionType(by: indexPath.section) else {
            return UICollectionReusableView()
        }

        switch servicesCollectionType {
        case .hotel:
            return UICollectionReusableView()
        case .services:
            let view: ServicesListHeaderReusableView = collectionView.dequeueReusableSupplementaryViewWithIndexPath(indexPath, kind: kind)
            view.fill(text: "Services")

            return view
        }
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let servicesCollectionType = viewModel.servicesCollectionType(by: section) else {
            return .zero
        }

        switch servicesCollectionType {
        case .hotel:
            return .zero
        case .services:
            return CGSize(width: view.frame.width, height: 32)
        }
    }
}

// MARK: - UICollectionViewDelegate
extension ServicesListViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let servicesCollectionType = viewModel.servicesCollectionType(by: indexPath.section) else {
            return
        }

        switch servicesCollectionType {
        case .hotel:
            break
        case .services:
            let serviceGroup = viewModel.getServiceGroup(for: indexPath.item)
            coordinatorDelegate?.didSelectServiceGroup(serviceGroup)
        }
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
extension ServicesListViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let servicesCollectionType = viewModel.servicesCollectionType(by: indexPath.section) else {
            return .zero
        }

        switch servicesCollectionType {
        case .hotel:
            return hotelSectionItemSize()
        case .services:
            return servicesSectionItemSize()
        }
    }

    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let servicesCollectionType = viewModel.servicesCollectionType(by: section) else {
            return UIEdgeInsets.zero
        }

        switch servicesCollectionType {
        case .hotel:
            return UIEdgeInsets(top: ServicesListViewController.Constants.sectionTopInset,
                                left: ServicesListViewController.Constants.sectionSideInset,
                                bottom: ServicesListViewController.Constants.sectionSideInset,
                                right: ServicesListViewController.Constants.sectionSideInset)
        case .services:
            return UIEdgeInsets(top: 12,
                                left: ServicesListViewController.Constants.sectionSideInset,
                                bottom: ServicesListViewController.Constants.sectionSideInset,
                                right: ServicesListViewController.Constants.sectionSideInset)
        }

    }

    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        guard let servicesCollectionType = viewModel.servicesCollectionType(by: section) else {
            return 0
        }

        switch servicesCollectionType {
        case .hotel:
            return 0
        case .services:
            return ServicesListViewController.Constants.interitemSpace
        }
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        guard let servicesCollectionType = viewModel.servicesCollectionType(by: section) else {
            return 0
        }

        switch servicesCollectionType {
        case .hotel:
            return 0
        case .services:
            return ServicesListViewController.Constants.interitemSpace
        }
    }
}

// MARK: - Section item size
private extension ServicesListViewController {
    func hotelSectionItemSize() -> CGSize {
        let sectionSideSpacing = ServicesListViewController.Constants.sectionSideInset * 2
        let width = view.frame.size.width - sectionSideSpacing
        let height = (width - ServicesListViewController.Constants.sectionSideInset) / 2

        return CGSize(width: width, height: height)
    }

    func servicesSectionItemSize() -> CGSize {
        let interitemSpaceCount = CGFloat(ServicesListViewController.Constants.columnsCount) - 1
        let interitemSpacing = ServicesListViewController.Constants.interitemSpace * interitemSpaceCount
        let sectionSideSpacing = ServicesListViewController.Constants.sectionSideInset * 2
        let generalSpacing = sectionSideSpacing + interitemSpacing + 1
        let side = (view.frame.size.width - generalSpacing) / CGFloat(ServicesListViewController.Constants.columnsCount)

        return CGSize(width: side, height: side)
    }
}

// MARK: - Constants
private extension ServicesListViewController {
    enum Constants {
        static let interitemSpace: CGFloat = 24
        static let sectionTopInset: CGFloat = 44
        static let sectionSideInset: CGFloat = 24
        static let columnsCount = 2
    }
}

