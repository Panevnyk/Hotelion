//
//  AddPersonalInfoViewController.swift
//  HotelionFastCheckIn
//
//  Created by Vladyslav Panevnyk on 13.01.2021.
//

import UIKit
import RxSwift
import RxCocoa
import HotelionCommon
import RestApiManager

public protocol AddPersonalInfoCoordinatorDelegate: BaseCoordinatorDelegate {
    func personalInfoWasAdded(from viewController: AddPersonalInfoViewController)
    func editDigitalSignature(signatureImage: UIImage?, from viewController: AddPersonalInfoViewController)
}

public final class AddPersonalInfoViewController: BaseScrollViewController {
    // MARK: - Properties
    // UI
    @IBOutlet private var headerView: HeaderView!
    @IBOutlet private var descriptionLabel: UITextView!
    @IBOutlet private var stepView: StepView!

    @IBOutlet private var personalTitleWithValidCheckerView: TitleWithValidCheckerView!
    @IBOutlet private var firstnameTextField: SUTextField!
    @IBOutlet private var lastnameTextField: SUTextField!
    @IBOutlet private var emailTextField: SUTextField!
    @IBOutlet private var phoneNumberTextField: SUTextField!

    @IBOutlet private var passportTitleWithValidCheckerView: TitleWithValidCheckerView!
    @IBOutlet private var passportNumberTextField: SUTextField!
    @IBOutlet private var passportFromTextField: SUTextField!
    @IBOutlet private var nationalityTextField: SUTextField!
    @IBOutlet private var placeOfResidenceTextField: SUTextField!
    @IBOutlet private var dateOfBirthTextField: SUDateTextField!

    @IBOutlet private var digitalSignatureTitleWithValidCheckerView: TitleWithValidCheckerView!
    @IBOutlet private var digitalSignatureView: DigitalSignatureView!

    @IBOutlet private var privacyPolicyLabel: UILabel!
    @IBOutlet private var privacyPolicyButton: UIButton!

    @IBOutlet private var checkInButton: VioletButton!


    // Coordinator delegate
    public weak var coordinatorDelegate: AddPersonalInfoCoordinatorDelegate?

    // ViewModels
    public var viewModel: AddPersonalInfoViewModel!
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
private extension AddPersonalInfoViewController {
    func setupViewModels() {
        preSetFields()
        bindUI()
        bindViewModel()
    }

    func bindUI() {
        // personal data
        firstnameTextField.textField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.firstname)
            .disposed(by: disposeBag)

        lastnameTextField.textField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.lastname)
            .disposed(by: disposeBag)

        emailTextField.textField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)

        phoneNumberTextField.textField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.phoneNumber)
            .disposed(by: disposeBag)

        // passport data
        passportNumberTextField.textField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.passportNumber)
            .disposed(by: disposeBag)

        passportFromTextField.textField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.passportFrom)
            .disposed(by: disposeBag)

        nationalityTextField.textField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.nationality)
            .disposed(by: disposeBag)

        placeOfResidenceTextField.textField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.placeOfResidence)
            .disposed(by: disposeBag)

        dateOfBirthTextField.textField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.dateOfBirth)
            .disposed(by: disposeBag)
    }

    func bindViewModel() {
        // personal data
        viewModel.firstnameValidationResult
            .bind(to: firstnameTextField.validationResultObservable)
            .disposed(by: disposeBag)

        viewModel.lastnameValidationResult
            .bind(to: lastnameTextField.validationResultObservable)
            .disposed(by: disposeBag)

        viewModel.emailValidationResult
            .bind(to: emailTextField.validationResultObservable)
            .disposed(by: disposeBag)

        viewModel.phoneNumberValidationResult
            .bind(to: phoneNumberTextField.validationResultObservable)
            .disposed(by: disposeBag)

        // passport data
        viewModel.passportNumberValidationResult
            .bind(to: passportNumberTextField.validationResultObservable)
            .disposed(by: disposeBag)

        viewModel.passportFromValidationResult
            .bind(to: passportFromTextField.validationResultObservable)
            .disposed(by: disposeBag)

        viewModel.nationalityValidationResult
            .bind(to: nationalityTextField.validationResultObservable)
            .disposed(by: disposeBag)

        viewModel.placeOfResidenceValidationResult
            .bind(to: placeOfResidenceTextField.validationResultObservable)
            .disposed(by: disposeBag)

        viewModel.dateOfBirthValidationResult
            .bind(to: dateOfBirthTextField.validationResultObservable)
            .disposed(by: disposeBag)


        // digital signature
        viewModel.digitalSignatureStatus
            .bind(to: digitalSignatureView.digitalSignatureStatus)
            .disposed(by: disposeBag)

        // isValid
        viewModel.isPersonalDataValid
            .bind(to: personalTitleWithValidCheckerView.isValid)
            .disposed(by: disposeBag)

        viewModel.isPassportDataValid
            .bind(to: passportTitleWithValidCheckerView.isValid)
            .disposed(by: disposeBag)

        viewModel.isDigitalSignatureValid
            .bind(to: digitalSignatureTitleWithValidCheckerView.isValid)
            .disposed(by: disposeBag)

        viewModel.isValid
            .bind(to: checkInButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }

    private func preSetFields() {
        let user = UserData.shared.user

        firstnameTextField.text = user.firstname
        lastnameTextField.text = user.lastname
        emailTextField.text = user.email
        phoneNumberTextField.text = user.phoneNumber

        if let passportData = user.passportData {
            passportNumberTextField.text = passportData.number
            passportFromTextField.text = passportData.from
            nationalityTextField.text = passportData.nationality
            placeOfResidenceTextField.text = passportData.placeOfResidence

            let date = Date(timeIntervalSince1970MiliSec: passportData.dateOfBirth)
            let dateFormatter = DateHelper.shared.dateStyleFormatter

            dateOfBirthTextField.text = dateFormatter.string(from: date)
        }

        let signature = user.digitalSignature ?? ""
        let signatureStatus = DigitalSignatureStatus.makeFrom(signature)
        viewModel.digitalSignatureStatus.accept(signatureStatus)
    }
}

// MARK: - Customize
private extension AddPersonalInfoViewController {
    func setupUI() {
        headerView.setTitle("Add personal info")
        headerView.isBackButtonHidden = false
        headerView.delegate = self

        stepView.fill(countOfSteps: 2, currentStep: 1)
        stepView.isHidden = isStepViewHidden
        
        descriptionLabel.attributedText = makeAttributedDescription()
        descriptionLabel.backgroundColor = .clear
        descriptionLabel.tintColor = UIColor.kViolet
        descriptionLabel.isSelectable = true
        descriptionLabel.isEditable = false
        descriptionLabel.isScrollEnabled = false
        descriptionLabel.textContainerInset = .zero
        descriptionLabel.textContainer.lineFragmentPadding = 0

        personalTitleWithValidCheckerView.fill(text: "Personal data")

        firstnameTextField.placeholder = "First name"
        firstnameTextField.config = .name

        lastnameTextField.placeholder = "Last name"
        lastnameTextField.config = .name

        emailTextField.placeholder = "Email"
        emailTextField.config = .email

        phoneNumberTextField.placeholder = "Phone number"
        phoneNumberTextField.config = .phoneNumber

        passportTitleWithValidCheckerView.fill(text: "Passport data")

        passportNumberTextField.placeholder = "Passport №"
        passportNumberTextField.config = .name

        passportFromTextField.placeholder = "Passport from"
        passportFromTextField.config = .name

        nationalityTextField.placeholder = "Nationality"
        nationalityTextField.config = .name

        placeOfResidenceTextField.placeholder = "Place of residence"
        placeOfResidenceTextField.config = .name

        dateOfBirthTextField.placeholder = "Date of birth"

        digitalSignatureTitleWithValidCheckerView.fill(text: "Digital signature")

        digitalSignatureView.delegate = self

        privacyPolicyLabel.text = "By check-in you agree to"
        privacyPolicyLabel.textColor = UIColor.kTextMiddleGray
        privacyPolicyLabel.font = UIFont.kPlainText

        privacyPolicyButton.setTitle("Privacy policy", for: .normal)
        privacyPolicyButton.setTitleColor(UIColor.kViolet, for: .normal)

        checkInButton.setTitle("Add", for: .normal)
        checkInButton.isEnabled = true
    }

    private func makeAttributedDescription() -> NSAttributedString {
        let sentence = "Before check-in add your personal information."
        let standartAttributes = [
            NSAttributedString.Key.font: UIFont.kTitleText,
            NSAttributedString.Key.foregroundColor: UIColor.kTextMiddleGray
        ]
        let attributedSentence = NSAttributedString(string: sentence, attributes: standartAttributes)

        return attributedSentence
    }
}

// MARK: - DigitalSignatureViewDelegate
extension AddPersonalInfoViewController: DigitalSignatureViewDelegate {
    func editDigitalSignature(from view: DigitalSignatureView, signatureImage: UIImage?) {
        coordinatorDelegate?.editDigitalSignature(signatureImage: signatureImage, from: self)
    }

    func removeDigitalSignatureAction(from view: DigitalSignatureView) {
        viewModel.removeDigitalSignatureAction()
    }
}

// MARK: - AddPersonalInfoViewModelDelegate
extension AddPersonalInfoViewController: AddPersonalInfoViewModelDelegate {
    public func personalInfoWasAdded() {
        coordinatorDelegate?.personalInfoWasAdded(from: self)
    }
}

// MARK: - HeaderViewDelegate
extension AddPersonalInfoViewController: HeaderViewDelegate {
    public func backAction(from view: HeaderView) {
        coordinatorDelegate?.didSelectBackAction()
    }
}

// MARK: - Actions
private extension AddPersonalInfoViewController {
    @IBAction func checkInAction() {
        viewModel.checkInAction()
    }
}
