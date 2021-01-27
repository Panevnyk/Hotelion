//
//  OrdersViewController.swift
//  HotelionOrders
//
//  Created by Vladyslav Panevnyk on 25.11.2020.
//

import UIKit
import RxSwift
import RxCocoa
import HotelionCommon

public class OrdersViewController: UIViewController {
    // MARK: - Properties
    // UI
    @IBOutlet private var tableView: UITableView!
    private var refreshControl = UIRefreshControl()

    // ViewModel
    public var viewModel: OrdersViewModelProtocol!

    // DisposeBag
    private let disposeBag = DisposeBag()

    // MARK: - Life cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Public methods
    public func setupTabBar() {
        tabBarItem.image = MainTab.orders.image
        tabBarItem.selectedImage = MainTab.orders.selectedImage?.withRenderingMode(.alwaysOriginal)

        viewModel.badgeValueObservable
            .bind(to: tabBarItem.rx.badgeValue)
            .disposed(by: disposeBag)
    }
}

// MARK: - UI
private extension OrdersViewController {
    func setupUI() {
        view.backgroundColor = .kBackground

        refreshControl.tintColor = .black
        refreshControl.addTarget(self, action: #selector(updateList), for: .valueChanged)
        
        tableView.backgroundColor = .kBackground
        tableView.refreshControl = refreshControl
        tableView.register(cell: OrderTableViewCell.self, bundle: Bundle.orders)
    }

    @objc private func updateList() {
        viewModel.reloadList { [weak self] in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension OrdersViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsCount(in: section)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrderTableViewCell = tableView.dequeueReusableCellWithIndexPath(indexPath)
        let itemViewModel = viewModel.orderViewModel(for: indexPath.row)
        cell.fill(viewModel: itemViewModel)

        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension OrdersViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    public func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        UIView.animate(withDuration: 0.2) {
            cell?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }

    public func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        UIView.animate(withDuration: 0.2) {
            cell?.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
}

// MARK: - OrdersViewModelDelegate
extension OrdersViewController: OrdersViewModelDelegate {
    public func reloadData() {
        tableView?.reloadData()
    }
}
