//
//  FastCheckInCoordinator.swift
//  HotelionMain
//
//  Created by Vladyslav Panevnyk on 13.01.2021.
//  Copyright © 2021 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import HotelionFastCheckIn
import HotelionCommon

protocol FastCheckInDelegate: class {
    func didLoadBoking(currentBooking: Booking)
}


final class FastCheckInCoordinator {
    // MARK: - Properties
    private let serviceFactory: ServiceFactoryProtocol
    private let navigationController: UINavigationController

    weak var delegate: FastCheckInDelegate?

    private weak var checkInMainViewController: CheckInMainViewController?
    private weak var fastCheckInViewController: FastCheckInViewController?
    private weak var addPersonalInfoViewController: AddPersonalInfoViewController?
    private weak var digitalSignatureViewController: DigitalSignatureViewController?
    private weak var scannerViewController: ScannerViewController?

    // MARK: - Inits
    init(navigationController: UINavigationController,
         serviceFactory: ServiceFactoryProtocol) {
        self.navigationController = navigationController
        self.serviceFactory = serviceFactory
    }

    // MARK: - Starts
    func start(animated: Bool) {
        startCheckInMain(animated: true)
    }

    private func startCheckInMain(animated: Bool) {
        let checkInMainAssembly = CheckInMainAssembly(
            serviceFactory: serviceFactory
        )
        checkInMainAssembly.viewController.coordinatorDelegate = self
        checkInMainAssembly.viewController.setupTabBar()
        self.checkInMainViewController = checkInMainAssembly.viewController

        navigationController.setViewControllers([checkInMainAssembly.viewController],
                                                animated: animated)
    }
}

// MARK: - CheckInMainCoordinatorDelegate
extension FastCheckInCoordinator: CheckInMainCoordinatorDelegate {
    func goToFastCheckInAction(from viewController: CheckInMainViewController) {
        if UserData.shared.user.isPersonalInfoFull {
            pushFastCheckIn()
        } else {
            pushAddPersonalInfo(isStepViewHidden: false)
        }
    }

    func didLoadBoking(currentBooking: Booking,
                       from viewController: CheckInMainViewController) {
        delegate?.didLoadBoking(currentBooking: currentBooking)
    }

    private func pushFastCheckIn(isStepViewHidden: Bool = true) {
        let fastCheckInAssembly = FastCheckInAssembly(
            serviceFactory: serviceFactory
        )
        fastCheckInAssembly.viewController.coordinatorDelegate = self
        fastCheckInAssembly.viewController.isStepViewHidden = isStepViewHidden
        self.fastCheckInViewController = fastCheckInAssembly.viewController

        navigationController.pushViewController(fastCheckInAssembly.viewController, animated: true)
    }

    private func pushAddPersonalInfo(isStepViewHidden: Bool = true) {
        let addPersonalInfoAssembly = AddPersonalInfoAssembly(
            serviceFactory: serviceFactory
        )
        addPersonalInfoAssembly.viewController.coordinatorDelegate = self
        addPersonalInfoAssembly.viewController.isStepViewHidden = isStepViewHidden
        self.addPersonalInfoViewController = addPersonalInfoAssembly.viewController

        navigationController.pushViewController(addPersonalInfoAssembly.viewController, animated: true)
    }
}

// MARK: - FastCheckInCoordinatorDelegate
extension FastCheckInCoordinator: FastCheckInCoordinatorDelegate {
    func bookingRequestWasCreated(bookingRequest: BookingRequest) {
        startCheckInMain(animated: true)
    }

    func didTapQRScanning() {
        let scannerAssembly = ScannerAssembly()
        scannerAssembly.viewController.coordinatorDelegate = self
        scannerViewController = scannerAssembly.viewController

        navigationController.present(scannerAssembly.viewController, animated: true, completion: nil)
    }

    func didTapPersonalInfo() {
        pushAddPersonalInfo()
    }
}

// MARK: - AddPersonalInfoCoordinatorDelegate
extension FastCheckInCoordinator: AddPersonalInfoCoordinatorDelegate {
    func personalInfoWasAdded(from viewController: AddPersonalInfoViewController) {
        if viewController.isStepViewHidden {
            didSelectBackAction()
        } else {
            pushFastCheckIn(isStepViewHidden: false)
        }
    }

    func editDigitalSignature(signatureImage: UIImage?, from viewController: AddPersonalInfoViewController) {
        let digitalSignatureAssembly = DigitalSignatureAssembly(
            serviceFactory: serviceFactory
        )
        digitalSignatureAssembly.viewController.coordinatorDelegate = self
        digitalSignatureAssembly.viewController.signatureImage = signatureImage
        self.digitalSignatureViewController = digitalSignatureAssembly.viewController

        navigationController.present(digitalSignatureAssembly.viewController, animated: true, completion: nil)
    }

    func didSelectBackAction() {
        navigationController.popViewController(animated: true)
    }
}

// MARK: - ScannerCoordinatorDelegate
extension FastCheckInCoordinator: ScannerCoordinatorDelegate {
    func found(code: String, from viewController: ScannerViewController) {
        fastCheckInViewController?.viewModel.qrCode.accept(code)
        dismiss(from: viewController)
    }

    func dismiss(from viewController: ScannerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}

// MARK: - DigitalSignatureCoordinatorDelegate
extension FastCheckInCoordinator: DigitalSignatureCoordinatorDelegate {
    func didAddDigitalSignature(signature: String, from viewController: DigitalSignatureViewController) {
        let digitalSignatureStatus = DigitalSignatureStatus.makeFrom(signature)
        addPersonalInfoViewController?.viewModel.digitalSignatureStatus.accept(digitalSignatureStatus)
        dismiss(from: viewController)
    }

    func dismiss(from viewController: DigitalSignatureViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
