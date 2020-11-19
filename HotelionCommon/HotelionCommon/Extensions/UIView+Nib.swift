//
//  UIView+Nib.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 11.11.2020.
//

import UIKit

func string(nibClass: UIView.Type) -> String {
    return String(describing: nibClass)
}

func string(className: NSObject.Type) -> String {
    return String(describing: className)
}

public extension UIView {
    @discardableResult
    func addSelfNibUsingConstraints(nibName: String, bundle: Bundle) -> UIView? {
        guard let nibView = loadSelfNib(nibName: nibName, bundle: bundle) else {
            assert(true, "---- UIView Extension Nib file not found ----")
            return nil
        }
        addSubviewUsingConstraints(view: nibView)
        return nibView
    }

    @discardableResult
    func addSelfNibUsingConstraints(bundle: Bundle) -> UIView? {
        guard let nibView = loadSelfNib(bundle: bundle) else {
            assert(true, "---- UIView Extension Nib file not found ----")
            return nil
        }
        addSubviewUsingConstraints(view: nibView)
        return nibView
    }

    func loadSelfNib(bundle: Bundle) -> UIView? {
        let nibName = String(describing: type(of: self))
        if let nibFiles = bundle.loadNibNamed(nibName, owner: self, options: nil),
            nibFiles.count > 0 {
            return nibFiles.first as? UIView
        }
        return nil
    }

    func loadSelfNib(nibName: String, bundle: Bundle) -> UIView? {
        if let nibFiles = bundle.loadNibNamed(nibName, owner: self, options: nil), nibFiles.count > 0 {
            return nibFiles.first as? UIView
        }
        return nil
    }

    // Add subview
    func addSubviewUsingConstraints(view: UIView, insets: UIEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)

        let left = NSLayoutConstraint(item: view,
                                      attribute: .left,
                                      relatedBy: .equal,
                                      toItem: self,
                                      attribute: .left,
                                      multiplier: 1,
                                      constant: insets.left)
        let top = NSLayoutConstraint(item: view,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: self,
                                     attribute: .top,
                                     multiplier: 1,
                                     constant: insets.top)
        let right = NSLayoutConstraint(item: self,
                                       attribute: .trailing,
                                       relatedBy: .equal,
                                       toItem: view,
                                       attribute: .trailing,
                                       multiplier: 1,
                                       constant: insets.right)
        let bottom = NSLayoutConstraint(item: self,
                                        attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: view,
                                        attribute: .bottom,
                                        multiplier: 1,
                                        constant: insets.bottom)
        addConstraints([left, top, right, bottom])
    }
}

public extension UIView {
    func addConstraintForBottomView(view: UIView,
                                    bottom: CGFloat,
                                    leading: CGFloat,
                                    traling: CGFloat,
                                    height: CGFloat) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: traling),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leading),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottom),
            view.heightAnchor.constraint(equalToConstant: height)
            ])
    }

    func addRightConstraint(view: UIView,
                            top: CGFloat,
                            traling: CGFloat,
                            width: CGFloat,
                            height: CGFloat) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: traling),
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: top),
            view.widthAnchor.constraint(equalToConstant: width),
            view.heightAnchor.constraint(equalToConstant: height)
            ])
    }
}

// MARK: - Constraints
public extension UIView {
    func constraint(toView view: UIView) -> [NSLayoutConstraint] {
        return [
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
    }

    func removeAllSubviews() {
        subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
    }
}
