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
    
    public func show() {
        hide()
        createActivityIndicatorView()
    }

    public func show(onView view: UIView) {
        hide()
        createActivityIndicatorView(onView: view)
    }
    
    public func hide() {
        if let activityIndicatorView = activityIndicatorView {
            activityIndicatorView.hide()
        }
    }
    
    private func createActivityIndicatorView() {
        if let vc = UIApplication.presentationViewController {
            createActivityIndicatorView(onView: vc.view)
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
