//
//  NavigationItemFactory.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 11.11.2020.
//

import UIKit

public final class NavigationItemFactory: NSObject {
    public class func createFilterItem(viewController: UIViewController, selector: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(title: "Filter", style: .done, target: viewController, action: selector)
    }

    public class func createMenuItem(viewController: UIViewController, selector: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(image: UIImage(named: "icMenu", in: Bundle.common, compatibleWith: nil), style: .done, target: viewController, action: selector)
    }

    public class func createAddItem(viewController: UIViewController, selector: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(image: UIImage(named: "icAdd", in: Bundle.common, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal),
                               style: .done,
                               target: viewController,
                               action: selector)
    }

    public class func createEditItem(viewController: UIViewController, selector: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(title: "Edit", style: .done, target: viewController, action: selector)
    }

    public class func createEditImgItem(viewController: UIViewController, selector: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(image: UIImage(named: "icEdit", in: Bundle.common, compatibleWith: nil),
                               style: .done,
                               target: viewController,
                               action: selector)
    }

    public class func createBackItem(viewController: UIViewController, selector: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(image: UIImage(named: "icArrowLeft", in: Bundle.common, compatibleWith: nil),
                               style: .done,
                               target: viewController,
                               action: selector)
    }

    public class func createDoneItem(viewController: UIViewController, selector: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(title: "Done", style: .done, target: viewController, action: selector)
    }

    public class func createCancelItem(viewController: UIViewController, selector: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(title: "Cancel", style: .done, target: viewController, action: selector)
    }

    public class func createSendItem(viewController: UIViewController, selector: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(title: "Send", style: .done, target: viewController, action: selector)
    }

    public class func createLogOutItem(viewController: UIViewController, selector: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(image: UIImage(named: "icExit", in: Bundle.common, compatibleWith: nil),
                               style: .done,
                               target: viewController,
                               action: selector)
    }

    public class func createNavigationTitle(senderName: String, senderAvatar: String) -> UIView {
        let view = UIView()

        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        lbl.text = senderName
        lbl.textColor = UIColor.kTextDarkGray
        lbl.numberOfLines = 2
        view.addSubview(lbl)

        let avatarImageView = UIImageView()
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
//        avatarImageView.setImage(url: URL(string: senderAvatar), placeholder: "imgAccountPlaceholder")
        avatarImageView.layer.cornerRadius = 12
        avatarImageView.layer.masksToBounds = true
        view.addSubview(avatarImageView)

        NSLayoutConstraint.activate([lbl.topAnchor.constraint(equalTo: view.topAnchor),
                                     view.bottomAnchor.constraint(equalTo: lbl.bottomAnchor),
                                     view.trailingAnchor.constraint(equalTo: lbl.trailingAnchor),
                                     avatarImageView.widthAnchor.constraint(equalToConstant: 24),
                                     avatarImageView.heightAnchor.constraint(equalToConstant: 24),
                                     avatarImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     avatarImageView.trailingAnchor.constraint(equalTo: lbl.leadingAnchor, constant: -6),
                                     avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        return view
    }
}

