//
//  CheckInMainViewModel.swift
//  HotelionFastCheckIn
//
//  Created by Vladyslav Panevnyk on 21.01.2021.
//

import RxSwift
import RxCocoa
import HotelionCommon

public protocol CheckInMainViewModelProtocol {
    var isMessageHiddenObservable: Observable<Bool> { get }
    var messageObservable: Observable<String> { get }
    var isActionHiddenObservable: Observable<Bool> { get }
    var actionTitleObservable: Observable<String?> { get }

    func refreshData(completion: (() -> Void)?)
}

public protocol CheckInMainViewModelDelegate: class {
    func didLoadBoking(currentBooking: Booking)
}

public final class CheckInMainViewModel: CheckInMainViewModelProtocol {
    // MARK: - Properties
    // Boundaries
    private let bookingRequestsLoader: BookingRequestsLoaderProtocol
    private let bookingsLoader: BookingsLoaderProtocol

    // BehaviourRelay
    private var isMessageHidden = BehaviorRelay<Bool>(value: true)
    private var message = BehaviorRelay<String>(value: "")
    private var isActionHidden = BehaviorRelay<Bool>(value: true)
    private var actionTitle = BehaviorRelay<String?>(value: nil)

    // ToView
    public lazy var isMessageHiddenObservable = isMessageHidden.asObservable()
    public lazy var messageObservable = message.asObservable()
    public lazy var isActionHiddenObservable = isActionHidden.asObservable()
    public lazy var actionTitleObservable = actionTitle.asObservable()

    private let disposeBag = DisposeBag()

    // Delegate
    public weak var delegate: CheckInMainViewModelDelegate?

    // MARK: - Inits
    public init(bookingRequestsLoader: BookingRequestsLoaderProtocol,
                bookingsLoader: BookingsLoaderProtocol) {
        self.bookingRequestsLoader = bookingRequestsLoader
        self.bookingsLoader = bookingsLoader

        loadData()
        bindData()
    }
}

// MARK: - Public Methods
extension CheckInMainViewModel {
    public func refreshData(completion: (() -> Void)?) {
        bookingsLoader.loadBookings { [weak self] (result) in
            switch result {
            case .success(let bookings):
                if let currentBooking = bookings.first {
                    self?.delegate?.didLoadBoking(currentBooking: currentBooking)
                }
            case .failure(let error):
                NotificationBannerHelper.showBanner(error)
            }
            completion?()
        }
    }
}

// MARK: - Load
private extension CheckInMainViewModel {
    func loadData() {
        bookingRequestsLoader.loadBookingRequests(completion: nil)
    }
}

// MARK: - Bind
private extension CheckInMainViewModel {
    func bindData() {
        bookingRequestsLoader.resultPublisher.bind { [weak self] (result) in
            guard let self = self else { return }

            self.isMessageHidden.accept(false)

            switch result {
            case .success(let bookingRequests):
                if bookingRequests.count > 0 {
                    self.message.accept("Your check-in is successful.\n\nPlease, wait for confirm from administration.")
                    self.isActionHidden.accept(true)
                    self.actionTitle.accept(nil)
                } else {
                    self.message.accept("If you want to avoid paper routine, you can simply enter your personal data in Hotelion once.\n\nAfter this, you can check-in with one tap using fast check-in feature.")
                    self.isActionHidden.accept(false)
                    self.actionTitle.accept("Go to Fast Check-in")
                }
            case .failure(let error):
                NotificationBannerHelper.showBanner(error)
            }
        }.disposed(by: disposeBag)
    }
}
