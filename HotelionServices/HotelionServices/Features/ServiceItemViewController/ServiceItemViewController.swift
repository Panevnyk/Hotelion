//
//  ServiceItemViewController.swift
//  HotelionServices
//
//  Created by Vladyslav Panevnyk on 17.11.2020.
//

import UIKit
import HotelionCommon

public protocol ServiceItemCoordinatorDelegate: BaseCoordinatorDelegate {}

public final class ServiceItemViewController: UIViewController {
    // MARK: - Properties
    // UI
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var containerScrollView: UIView!
    @IBOutlet private var detailsHeaderView: DetailsHeaderView!
    @IBOutlet private var serviceOptionsViewWithContainer: OptionsViewWithContainer!
    @IBOutlet private var deliveryOptionsWithContainer: OptionsViewWithContainer!
    @IBOutlet private var expandableDescriptionWithContainer: ExpandableDescriptionWithContainer!
    @IBOutlet private var priceView: PriceView!

    private var serviceOptionsView: OptionsView {
        serviceOptionsViewWithContainer.wrappedView
    }
    private var deliveryOptionsView: OptionsView {
        deliveryOptionsWithContainer.wrappedView
    }
    private var expandableDescriptionView: ExpandableDescriptionView {
        expandableDescriptionWithContainer.wrappedView
    }

    // ViewModel
    public var viewModel: ServiceItemViewModelProtocol!

    // Delegates
    public weak var coordinatorDelegate: ServiceItemCoordinatorDelegate?

    // MARK: - Life cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
}

// MARK: - ViewModels
private extension ServiceItemViewController {
    func bindViewModel() {
        expandableDescriptionView.bind(textObservable: viewModel.descriptionTextObservable)
        priceView.bind(priceObservable: viewModel.totalPriceObservable)
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
        expandableDescriptionWithContainer.setText("Description")

        serviceOptionsView.options = viewModel.getServiceOptions()
        serviceOptionsView.delegate = self

        deliveryOptionsView.options = viewModel.getDeliveryOptions()
        deliveryOptionsView.delegate = self

        expandableDescriptionView.delegate = self
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

// MARK: - UIScrollViewDelegate
extension ServiceItemViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        detailsHeaderView.updateByScrollView(scrollView)
    }
}
