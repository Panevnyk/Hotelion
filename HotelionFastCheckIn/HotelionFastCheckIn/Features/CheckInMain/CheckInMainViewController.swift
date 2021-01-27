//
//  FastCheckInMainViewController.swift
//  HotelionFastCheckIn
//
//  Created by Vladyslav Panevnyk on 20.01.2021.
//

import UIKit
import RxSwift
import RxCocoa
import HotelionCommon

public protocol CheckInMainCoordinatorDelegate: class {
    func goToFastCheckInAction(from viewController: CheckInMainViewController)
    func didLoadBoking(currentBooking: Booking, from viewController: CheckInMainViewController)
}

public final class CheckInMainViewController: UIViewController {
    // MARK: - Properties
    // UI
    @IBOutlet private var headerView: HeaderView!
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var scrollContainerView: UIView!
    @IBOutlet private var messageView: MessageView!
    @IBOutlet private var actionButton: VioletButton!

    private let refreshControl = UIRefreshControl()

    // ViewModel
    public var viewModel: CheckInMainViewModelProtocol!
    private let disposeBag = DisposeBag()

    // Delegate
    public weak var coordinatorDelegate: CheckInMainCoordinatorDelegate?

    // MARK: - Life cycle
    public override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bind()
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}

// MARK: - Bind
private extension CheckInMainViewController {
    func bind() {
        bindFromViewModel()
    }

    func bindFromViewModel() {
        viewModel.isMessageHiddenObservable
            .bind(to: messageView.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel.messageObservable
            .subscribe { (value) in
                self.messageView.setMessage(value)
            }
            .disposed(by: disposeBag)

        viewModel.isActionHiddenObservable
            .bind(to: actionButton.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel.actionTitleObservable
            .bind(to: actionButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
    }
}

// MARK: - UI
extension CheckInMainViewController {
    // MARK: - Public methods
    public func setupTabBar() {
        tabBarItem.image = MainTab.home.image
        tabBarItem.selectedImage = MainTab.home.selectedImage?.withRenderingMode(.alwaysOriginal)
    }

    // MARK: - UI
    private func setupUI() {
        headerView.setTitle("Wellcome!")

        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        scrollView.refreshControl = refreshControl
    }
}

// MARK: - CheckInMainViewModelDelegate
extension CheckInMainViewController: CheckInMainViewModelDelegate {
    public func didLoadBoking(currentBooking: Booking) {
        coordinatorDelegate?.didLoadBoking(currentBooking: currentBooking, from: self)
    }
}

// MARK: - Actions
private extension CheckInMainViewController {
    @IBAction func goToFastCheckInAction(_ sender: Any) {
        coordinatorDelegate?.goToFastCheckInAction(from: self)
    }

    @objc func refresh(_ sender: AnyObject) {
        viewModel.refreshData { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
}
