//
//  AlertViewAction.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 27.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation

enum AlertViewActionStyle {
    case `default`
    case cancel
    case done

    var defaultTitle: String {
        switch self {
        case .default: return ""
        case .cancel: return "Cancel"
        case .done: return "Done"
        }
    }

    var defaultAction: AlertViewActionType {
        switch self {
        case .default: return {}
        case .cancel: return {}
        case .done: return {}
        }
    }
}

typealias AlertViewActionType = (() -> Void)

struct AlertViewAction {
    private let title: String?
    private let style: AlertViewActionStyle
    private let action: AlertViewActionType?

    init(title: String? = nil, style: AlertViewActionStyle, action: AlertViewActionType? = nil) {
        self.title = title
        self.style = style
        self.action = action
    }

    func getTitle() -> String { title ?? style.defaultTitle }
    func getStyle() -> AlertViewActionStyle { style }
    func getAction() -> AlertViewActionType { action ?? style.defaultAction }
}
