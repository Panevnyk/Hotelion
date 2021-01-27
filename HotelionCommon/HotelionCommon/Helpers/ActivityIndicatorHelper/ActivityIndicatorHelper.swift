//
//  ActivityIndicatorHelper.swift
//  Hotelion
//
//  Created by Panevnyk Vlad on 3/23/20.
//

import UIKit

public final class ActivityIndicatorHelper {
    
    public static let shared = ActivityIndicatorHelper()
    
    private weak var activityIndicatorView: ActivityIndicatorView?
    private var isShow = false
    
    public func show() {
        if let vc = UIApplication.presentationViewController {
            show(onView: vc.view)
        }
    }

    public func show(onView view: UIView) {
        guard !isShow else { return }

        isShow = true
        createActivityIndicatorView(onView: view)
    }
    
    public func hide() {
        isShow = false
        if let activityIndicatorView = activityIndicatorView {
            activityIndicatorView.hide()
        }
    }
    
    private func createActivityIndicatorView(onView view: UIView) {
        let activityIndicatorView = ActivityIndicatorView(frame: view.bounds)
        view.addSubviewUsingConstraints(view: activityIndicatorView)
        activityIndicatorView.setupView()
        activityIndicatorView.show()
        self.activityIndicatorView = activityIndicatorView
    }
}
