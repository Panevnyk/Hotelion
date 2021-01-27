//
//  FastCheck-inStep1ViewController.swift
//  HotelionFastCheckIn
//
//  Created by Vladyslav Panevnyk on 13.01.2021.
//

import UIKit
import RxSwift
import RxCocoa
import HotelionCommon
import RestApiManager

public protocol FastCheckInCoordinatorDelegate: BaseCoordinatorDelegate {
    func bookingRequestWasCreated(bookingRequest: BookingRequest)
    func didTapQRScanning()
    func didTapPersonalInfo()
}

public final class FastCheckInViewController: BaseScrollViewController {
    // MARK: - Properties
    // Constants
    private static let openPersonalInfoURL = "http://www.google.com"

    // UI
    @IBOutlet private var headerView: HeaderView!
    @IBOutlet private var stepView: StepView!

    @IBOutlet private var descriptionLabel: UITextView!
    @IBOutlet private var hotelCodeTextField: SUTextField!
    @IBOutlet private var qrCodeView: QRCodeView!

    @IBOutlet private var nextStepButton: VioletButton!

    @IBOutlet private var separatorOneView: UIView!
    @IBOutlet private var separatorSecondView: UIView!
    @IBOutlet private var orLabel: UILabel!

    // Coordinator delegate
    public weak var coordinatorDelegate: FastCheckInCoordinatorDelegate?

    // ViewModels
    public var viewModel: FastCheckInViewModel!
    private let disposeBag = DisposeBag()

    public var isStepViewHidden = true

    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViewModels()
    }
}

// MARK: - ViewModels
private extension FastCheckInViewController {
    func setupViewModels() {
        bindUI()
        bindViewModel()
    }

    func bindUI() {
        hotelCodeTextField.textField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.hotelCode)
            .disposed(by: disposeBag)
    }

    func bindViewModel() {
        viewModel.isValid
            .bind(to: nextStepButton.rx.isEnabled)
            .disposed(by: disposeBag)

        viewModel.hotelCodeValidationResult
            .bind(to: hotelCodeTextField.validationResultObservable)
            .disposed(by: disposeBag)

        viewModel.qrCodeValidationResult
            .map { $0.isValid }
            .bind(to: qrCodeView.isValid)
            .disposed(by: disposeBag)
    }
}

// MARK: - Customize
private extension FastCheckInViewController {
    func setupUI() {
        nextStepButton.setTitle("Check-in", for: .normal)
        nextStepButton.isEnabled = true

        stepView.fill(countOfSteps: 2, currentStep: 2)
        stepView.isHidden = isStepViewHidden

        hotelCodeTextField.placeholder = "Hotel code"
        hotelCodeTextField.config = .name

        qrCodeView.delegate = self

        headerView.setTitle("Fast check-in")
        headerView.isBackButtonHidden = false
        headerView.delegate = self
        
        separatorOneView.backgroundColor = UIColor.kSeparatorGray
        separatorSecondView.backgroundColor = UIColor.kSeparatorGray

        orLabel.text = "or"
        orLabel.textColor = UIColor.kTextDarkGray
        orLabel.font = UIFont.kTitleText

        descriptionLabel.attributedText = makeAttributedDescription()
        descriptionLabel.backgroundColor = .clear
        descriptionLabel.tintColor = UIColor.kViolet
        descriptionLabel.isSelectable = true
        descriptionLabel.isEditable = false
        descriptionLabel.isScrollEnabled = false
        descriptionLabel.textContainerInset = .zero
        descriptionLabel.textContainer.lineFragmentPadding = 0
        descriptionLabel.delegate = self
    }

    private func makeAttributedDescription() -> NSAttributedString {
        let text1 = "Your "
        let text2 = "personal and passport data"
        let text3 = " is already available in Hotelion.\n\nFor fast check-in, please scan QR or write hotel code below."
        let sentence = text1 + text2 + text3
        let standartAttributes = [
            NSAttributedString.Key.font: UIFont.kTitleText,
            NSAttributedString.Key.foregroundColor: UIColor.kTextMiddleGray
        ]
        let selectedAttributes = [
            NSAttributedString.Key.font: UIFont.kTitleText,
            NSAttributedString.Key.foregroundColor: UIColor.kViolet,
            NSAttributedString.Key.link: URL(string: FastCheckInViewController.openPersonalInfoURL)!
        ] as [NSAttributedString.Key : Any]
        let attributedSentence = NSMutableAttributedString(string: sentence, attributes: standartAttributes)

        let range = NSRange(location: text1.count, length: text2.count)
        attributedSentence.setAttributes(selectedAttributes, range: range)

        return attributedSentence
    }
}

// MARK: - UITextViewDelegate
extension FastCheckInViewController: UITextViewDelegate {
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == FastCheckInViewController.openPersonalInfoURL {
            coordinatorDelegate?.didTapPersonalInfo()
        }
        return false
    }
}

// MARK: - FastCheckInViewModelDelegate
extension FastCheckInViewController: FastCheckInViewModelDelegate {
    public func bookingRequestWasCreated(bookingRequest: BookingRequest) {
        coordinatorDelegate?.bookingRequestWasCreated(bookingRequest: bookingRequest)
    }
}

// MARK: - QRCodeViewDelegate
extension FastCheckInViewController: QRCodeViewDelegate {
    func qrCodeDidTap() {
        coordinatorDelegate?.didTapQRScanning()
    }
}

// MARK: - HeaderViewDelegate
extension FastCheckInViewController: HeaderViewDelegate {
    public func backAction(from view: HeaderView) {
        coordinatorDelegate?.didSelectBackAction()
    }
}

// MARK: - Actions
private extension FastCheckInViewController {
    @IBAction func nextStepAction() {
        viewModel.nextStepAction()
    }
}
