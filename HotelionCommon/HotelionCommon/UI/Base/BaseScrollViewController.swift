//
//  BaseScrollViewController.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 11.11.2020.
//

import UIKit

open class BaseScrollViewController: UIViewController {
    ///UI
    @IBOutlet public var scrollView: UIScrollView! // swiftlint:disable:this private_outlet
    open var contentInsets = UIEdgeInsets.zero

    /// Life Cycle
    open override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.keyboardDismissMode = .interactive
        scrollView.alwaysBounceVertical = false
        //scrollView.delegate = self
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //add notifications
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_ :)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        /// dissmis keyboard
        view.endEditing(true)

        //remove notifications
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        scrollView?.flashScrollIndicators()
    }
}

// MARK: - UIScrollViewDelegate
extension BaseScrollViewController: UIScrollViewDelegate {
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //view.endEditing(true)
    }
}

// MARK: - Keyboard movements
extension BaseScrollViewController {
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }

        let insets = UIEdgeInsets(top: contentInsets.top,
                                  left: contentInsets.left,
                                  bottom: keyboardFrame.height + contentInsets.bottom,
                                  right: contentInsets.right)

        self.scrollView.contentInset = insets
        self.scrollView.scrollIndicatorInsets = insets
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }
}

