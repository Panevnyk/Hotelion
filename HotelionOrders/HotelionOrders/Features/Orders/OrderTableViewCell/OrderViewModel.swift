//
//  OrderViewModel.swift
//  HotelionOrders
//
//  Created by Vladyslav Panevnyk on 01.12.2020.
//

import UIKit
import HotelionCommon

public protocol OrderViewModelProtocol {
    var img: String { get }
    var name: String { get }
    var price: String { get }
    var currency: String { get }
    var bookingStatus: BookingStatus { get }
    var deliveryDescription: String { get }
    var deliveryDate: String { get }
}

final public class OrderViewModel: OrderViewModelProtocol {
    public let img: String
    public let name: String
    public let price: String
    public let currency: String
    public let bookingStatus: BookingStatus
    public let deliveryDescription: String
    public let deliveryDate: String
    public let creationDate: Double

    public init(img: String,
                name: String,
                price: String,
                currency: String,
                status: BookingStatus,
                deliveryDescription: String,
                deliveryDate: String,
                creationDate: Double) {
        self.img = img
        self.name = name
        self.price = price
        self.currency = currency
        self.bookingStatus = status
        self.deliveryDescription = deliveryDescription
        self.deliveryDate = deliveryDate
        self.creationDate = creationDate
    }
}

extension BookingStatus {
    public var title: String {
        switch self {
        case .waiting: return "Waiting"
        case .confirmed: return "Confirmed"
        case .canceled: return "Cancelled"
        case .completed: return "Completed"
        }
    }

    public var color: UIColor {
        switch self {
        case .waiting: return .kOrange
        case .confirmed: return .kGreen
        case .canceled: return .kRed
        case .completed: return .kGreen
        }
    }
}
