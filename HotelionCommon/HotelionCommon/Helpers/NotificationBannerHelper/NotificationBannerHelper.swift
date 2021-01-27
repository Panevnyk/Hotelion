//
//  NotificationBannerHelper.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 12.11.2020.
//

import NotificationBannerSwift

public final class NotificationBannerHelper: NSObject {
    public class func showErrorMessagge(_ text: String) {
        show(title: "", subtitle: text, style: .danger)
    }

    public class func showBanner(_ error: Error) {
        if let customError = error as? CustomRestApiError {
            showBanner(error: customError.error, success: nil)
        } else {
            showBanner(error: error, success: nil)
        }
    }

    public class func showBanner(error: Error?, success: String?) {
        var title = ""
        var subtitle = ""
        let style: BannerStyle

        if let error = error as NSError? {
            let arrError = localizedError(error)

            title = arrError.first?.count ?? 0 > 0 ? arrError.first! : "Error"
            subtitle = arrError.last ?? ""
            style = .danger
        } else {
            title = "Success"
            subtitle = success ?? ""
            style = .success
        }

        show(title: title, subtitle: subtitle, style: style)
    }

    public class func show(title: String, subtitle: String, style: BannerStyle) {
        DispatchQueue.main.async {
            let banner = NotificationBanner(title: title, subtitle: subtitle, leftView: nil, rightView: nil, style: style, colors: nil)
            banner.duration = 1.5
            banner.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            banner.subtitleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            banner.subtitleLabel?.lineBreakMode = .byTruncatingMiddle
            banner.show()
        }
    }

    // MARK: - Helper
    public class func localizedError(_ error: NSError) -> [String] {
        let arrErrors = error.userInfo["errors"]
        var strErrors = ""

        if let arrErrors = arrErrors as? [String] {
            for strError in arrErrors {
                strErrors += strErrors.count > 0 ? "\n" : ""
                strErrors += strError
            }
        }
        if strErrors.isEmpty {
            strErrors = "Request failed"
        }

        return ["", strErrors]
    }
}
