//
//  ServiceItemsListViewController.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 17.11.2020.
//

import UIKit
import HotelionCommon

public protocol ServiceItemsListCoordinatorDelegate: BaseCoordinatorDelegate {
    func didSelectService(_ service: Service)
}

public final class ServiceItemsListViewController: UIViewController {
    // MARK: - Properties
    // UI
    @IBOutlet private var headerView: HeaderView!
    @IBOutlet private var collectionView: UICollectionView!

    // ViewModel
    public var viewModel: ServiceItemsListViewModelProtocol!

    // Delegates
    public var coordinatorDelegate: ServiceItemsListCoordinatorDelegate?

    // MARK: - Life cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - UI
private extension ServiceItemsListViewController {
    func setupUI() {
        view.backgroundColor = .kBackground

        collectionView.register(cell: ServicesCustomImageListCollectionViewCell.self, bundle: Bundle.services)
        collectionView.backgroundColor = .kBackground

        headerView.setTitle(viewModel.getServiceGroupName())
        headerView.isBackButtonHidden = false
        headerView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource
extension ServiceItemsListViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemsCount(in: section)
    }

    public func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ServicesCustomImageListCollectionViewCell = collectionView.dequeueReusableCellWithIndexPath(indexPath)
        let itemViewModel = viewModel.servicesGroupViewModel(for: indexPath.item)
        cell.fill(viewModel: itemViewModel)

        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ServiceItemsListViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        coordinatorDelegate?.didSelectService(viewModel.getService(by: indexPath.item))
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
extension ServiceItemsListViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return servicesSectionItemSize()
    }

    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: ServiceItemsListViewController.Constants.sectionSideInset,
                            left: ServiceItemsListViewController.Constants.sectionSideInset,
                            bottom: ServiceItemsListViewController.Constants.sectionSideInset,
                            right: ServiceItemsListViewController.Constants.sectionSideInset)
    }

    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return ServiceItemsListViewController.Constants.interitemSpace
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ServiceItemsListViewController.Constants.interitemSpace
    }
}

// MARK: - Section item size
private extension ServiceItemsListViewController {
    func servicesSectionItemSize() -> CGSize {
        let interitemSpaceCount = CGFloat(ServiceItemsListViewController.Constants.columnsCount) - 1
        let interitemSpacing = ServiceItemsListViewController.Constants.interitemSpace * interitemSpaceCount
        let sectionSideSpacing = ServiceItemsListViewController.Constants.sectionSideInset * 2
        let generalSpacing = sectionSideSpacing + interitemSpacing + 1
        let side = (view.frame.size.width - generalSpacing) / CGFloat(ServiceItemsListViewController.Constants.columnsCount)

        return CGSize(width: side, height: side)
    }
}

// MARK: - ServiceItemsViewModelDelegate
extension ServiceItemsListViewController: ServiceItemsViewModelDelegate {
    public func reloadData() {
        collectionView.reloadData()
    }
}

// MARK: - HeaderViewDelegate
extension ServiceItemsListViewController: HeaderViewDelegate {
    public func backAction(from view: HeaderView) {
        coordinatorDelegate?.didSelectBackAction()
    }
}

// MARK: - Constants
private extension ServiceItemsListViewController {
    enum Constants {
        static let interitemSpace: CGFloat = 24
        static let sectionTopInset: CGFloat = 44
        static let sectionSideInset: CGFloat = 24
        static let columnsCount = 2
    }
}
