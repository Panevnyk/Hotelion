//
//  ProfileViewController.swift
//  HotelionProfile
//
//  Created by Vladyslav Panevnyk on 05.02.2021.
//

import UIKit
import RxSwift
import RxCocoa
import HotelionCommon

public final class ProfileViewController: BaseScrollViewController {
    // MARK: - Properties
    // UI
    @IBOutlet private var headerView: HeaderView!

    // ViewModel
    public var viewModel: ProfileViewModelProtocol!
    private let disposeBag = DisposeBag()

    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViewModels()
    }

    // MARK: - Public methods
    public func setupTabBar() {
        tabBarItem.image = MainTab.profile.image
        tabBarItem.selectedImage = MainTab.profile.selectedImage?.withRenderingMode(.alwaysOriginal)
    }
}

// MARK: - ViewModels
private extension ProfileViewController {
    func setupViewModels() {
        bindUI()
        bindViewModel()
    }

    func bindUI() {
    }

    func bindViewModel() {
    }
}

// MARK: - Customize
private extension ProfileViewController {
    func setupUI() {
        headerView.setTitle("Profile")
    }
}

