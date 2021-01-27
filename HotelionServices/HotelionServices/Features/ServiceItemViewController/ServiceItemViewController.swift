//
//  ServiceItemViewController.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 17.11.2020.
//

import UIKit
import HotelionCommon
import RxSwift
import RxCocoa

public protocol ServiceItemCoordinatorDelegate: BaseCoordinatorDelegate {}

public final class ServiceItemViewController: UIViewController {
    // MARK: - Properties
    // UI
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var containerScrollView: UIView!
    @IBOutlet private var detailsHeaderView: DetailsHeaderView!
    @IBOutlet private var serviceOptionsViewWithContainer: OptionsViewWithContainer!
    @IBOutlet private var deliveryOptionsWithContainer: OptionsViewWithContainer!
    @IBOutlet private var commentTextFieldWithContainer: SUTextFieldWithContainer!
    @IBOutlet private var expandableDescriptionWithContainer: ExpandableDescriptionWithContainer!
    @IBOutlet private var priceView: PriceView!

    private var serviceOptionsView: OptionsView {
        serviceOptionsViewWithContainer.wrappedView
    }
    private var deliveryOptionsView: OptionsView {
        deliveryOptionsWithContainer.wrappedView
    }
    private var commentTextField: SUTextField {
        commentTextFieldWithContainer.wrappedView
    }
    private var expandableDescriptionView: ExpandableDescriptionView {
        expandableDescriptionWithContainer.wrappedView
    }

    // ViewModel
    public var viewModel: ServiceItemViewModelProtocol!
    private let disposeBag = DisposeBag()

    // Delegates
    public weak var coordinatorDelegate: ServiceItemCoordinatorDelegate?

    // MARK: - Life cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
    }
}

// MARK: - ViewModels
private extension ServiceItemViewController {
    func setupBinding() {
        bindViewModel()
        bindUI()
    }

    func bindViewModel() {
        expandableDescriptionView.bind(textObservable: viewModel.descriptionTextObservable)
        priceView.bind(priceObservable: viewModel.totalPriceObservable)

        commentTextField.textField.rx.text
            .bind(to: viewModel.commentText)
            .disposed(by: disposeBag)
    }

    func bindUI() {
        viewModel.isDescriptionBlockHiddenObservable
            .bind(to: expandableDescriptionWithContainer.rx.isHidden)
            .disposed(by: disposeBag)
    }
}

// MARK: - UI
private extension ServiceItemViewController {
    func setupUI() {
        detailsHeaderView.setTitle(viewModel.getTitle())
        detailsHeaderView.set(images: viewModel.getHeaderImages())
        detailsHeaderView.delegate = self

        serviceOptionsViewWithContainer.setText("Options")
        deliveryOptionsWithContainer.setText("Delivery")
        commentTextFieldWithContainer.setText("Write a comment")
        expandableDescriptionWithContainer.setText("Description")

        commentTextField.placeholder = "Comment (optional)"
        commentTextField.config = .name

        serviceOptionsView.options = viewModel.getServiceOptions()
        serviceOptionsView.delegate = self

        deliveryOptionsView.options = viewModel.getDeliveryOptions()
        deliveryOptionsView.delegate = self

        expandableDescriptionView.delegate = self

        priceView.delegate = self
    }
}

// MARK: - DetailsHeaderViewDelegate
extension ServiceItemViewController: DetailsHeaderViewDelegate {
    func backAction(inView view: DetailsHeaderView) {
        coordinatorDelegate?.didSelectBackAction()
    }

    func didChangeState(_ state: HeaderState, inView view: DetailsHeaderView) {
        setNeedsStatusBarAppearanceUpdate()
    }
}

// MARK: - OptionsViewDelegate, ExpandableDescriptionViewDelegate
extension ServiceItemViewController: OptionsViewDelegate, ExpandableDescriptionViewDelegate {
    func optionsView(_ optionsView: OptionsView, removeTasteAt index: Int) {}

    func didSelectOption(_ optionsView: OptionsView, byItem item: Int) {
        switch optionsView {
        case serviceOptionsView:
            viewModel.didSelectServiceOption(by: item)
        case deliveryOptionsView:
            viewModel.didSelectDeliveryOption(by: item)
        default:
            break
        }
    }

    func getScreenRootView() -> UIView {
        return view
    }
}

// MARK: - PriceViewDelegate
extension ServiceItemViewController: PriceViewDelegate {
    func didTapOrder(in view: PriceView) {
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let orderAction = UIAlertAction(title: "Order", style: .default) { [weak self] _ in
            self?.viewModel.didTapOrder()
        }
        AlertHelper.show(title: "Order confirmation",
                         message: viewModel.getService().name,
                         alertActions: [cancelAction, orderAction])
    }
}

// MARK: - UIScrollViewDelegate
extension ServiceItemViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        detailsHeaderView.updateByScrollView(scrollView)
    }
}
