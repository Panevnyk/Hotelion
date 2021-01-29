//
//  OrderViewModel.swift
//  HotelionOrders
//
//  Created by Vladyslav Panevnyk on 01.12.2020.
//

import UIKit
import HotelionCommon

public protocol OrderViewModelProtocol {
    var orderId: String { get }
    var img: String { get }
    var name: String { get }
    var price: String { get }
    var currency: String { get }
    var orderStatus: OrderStatus { get }
    var deliveryDescription: String { get }
    var deliveryDate: String { get }
}

final public class OrderViewModel: OrderViewModelProtocol {
    public let orderId: String
    public let img: String
    public let name: String
    public let price: String
    public let currency: String
    public let orderStatus: OrderStatus
    public let deliveryDescription: String
    public let deliveryDate: String
    public let creationDate: Double

    public init(orderId: String,
                img: String,
                name: String,
                price: String,
                currency: String,
                status: OrderStatus,
                deliveryDescription: String,
                deliveryDate: String,
                creationDate: Double) {
        self.orderId = orderId
        self.img = img
        self.name = name
        self.price = price
        self.currency = currency
        self.orderStatus = status
        self.deliveryDescription = deliveryDescription
        self.deliveryDate = deliveryDate
        self.creationDate = creationDate
    }
}

extension OrderStatus {
    public var title: String {
        switch self {
        case .waiting: return "Waiting"
        case .confirmed: return "Confirmed"
        case .canceled: return "Canceled"
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

    public var isRemovable: Bool {
        switch self {
        case .waiting: return true
        case .confirmed: return true
        case .canceled: return false
        case .completed: return false
        }
    }
}
