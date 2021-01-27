//
//  FastCheck_inStep1ViewModel.swift
//  HotelionFastCheckIn
//
//  Created by Vladyslav Panevnyk on 13.01.2021.
//

import RestApiManager
import RxSwift
import RxCocoa
import HotelionCommon

public protocol FastCheckInViewModelProtocol {
    /// From View
    var hotelCode: BehaviorRelay<String> { get }
    var qrCode: BehaviorRelay<String> { get }

    /// Observables
    var hotelCodeValidationResult: Observable<ValidationResult> { get }
    var qrCodeValidationResult: Observable<ValidationResult> { get }
    var isValid: Observable<Bool> { get }

    /// Actions
    func nextStepAction()
}

public protocol FastCheckInViewModelDelegate: class {
    func bookingRequestWasCreated(bookingRequest: BookingRequest)
}

public final class FastCheckInViewModel: FastCheckInViewModelProtocol {
    // MARK: - Properties
    // Boundaries
    private let restApiManager: RestApiManager
    private let bookingRequestsLoader: BookingRequestsLoaderProtocol

    // Delegate
    public weak var delegate: FastCheckInViewModelDelegate?

    // Validators
    private let hotelCodeValidator: ValidatorProtocol = CodeValidator()
    private let qrCodeValidator: ValidatorProtocol = CodeValidator()

    // From View
    public var hotelCode = BehaviorRelay<String>(value: "")
    public var qrCode = BehaviorRelay<String>(value: "")

    public var hotelCodeValidationResult: Observable<ValidationResult> {
        return hotelCode.asObservable().map({ (email) -> ValidationResult in
            return self.hotelCodeValidator.validate(email)
        })
    }

    public var qrCodeValidationResult: Observable<ValidationResult> {
        return qrCode.asObservable().map({ (password) -> ValidationResult in
            return self.qrCodeValidator.validate(password)
        })
    }

    public var isValid: Observable<Bool> {
        return Observable.combineLatest(hotelCodeValidationResult, qrCodeValidationResult) { hotelCode, qrCode in
            return hotelCode.isValid || qrCode.isValid
        }
    }

    // MARK: - Inits
    public init(restApiManager: RestApiManager, bookingRequestsLoader: BookingRequestsLoaderProtocol) {
        self.restApiManager = restApiManager
        self.bookingRequestsLoader = bookingRequestsLoader
    }
}

// MARK: - RestApiable
extension FastCheckInViewModel {
    public func nextStepAction() {
        let code = !qrCode.value.isEmpty ? qrCode.value : hotelCode.value
        let parameters = HotelByCodeParameters(code: code)
        let method = HotelRestApiMethods.getHotelByCode(parameters)

        ActivityIndicatorHelper.shared.show()
        restApiManager.call(method: method) { [weak self] (result: Result<Hotel>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let hotel):
                    self?.createBookingRequest(hotel: hotel)
                case .failure(let error):
                    ActivityIndicatorHelper.shared.hide()
                    NotificationBannerHelper.showBanner(error)
                }
            }
        }
    }
    public func createBookingRequest(hotel: Hotel) {
        bookingRequestsLoader.createBookingRequest(hotelId: hotel.id) { [weak self] (result: Result<BookingRequest>) in
            ActivityIndicatorHelper.shared.hide()

            switch result {
            case .success(let bookingRequest):
                self?.delegate?.bookingRequestWasCreated(bookingRequest: bookingRequest)
            case .failure(let error):
                NotificationBannerHelper.showBanner(error)
            }
        }
    }
}
