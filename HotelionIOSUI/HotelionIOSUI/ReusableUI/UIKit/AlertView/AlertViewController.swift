//
//  AlertViewController.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 30.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit

final class AlertViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet private var backgroundContainerView: UIView!
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var corneredContainerView: UIView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var contentStackView: UIStackView!
    @IBOutlet private var actionStackView: UIStackView!
    
    private var title1: String? = nil
    private var contentView: UIView? = nil
    private var actions: [AlertViewAction] = []

    private let animator = AlertViewAnimator()

    // MARK: - Inits
    init(title: String? = nil, contentView: UIView? = nil, actions: [AlertViewAction] = []) {
        self.title1 = title
        self.contentView = contentView
        self.actions = actions

        super.init(nibName: AlertViewController.name, bundle: Bundle.uiModuleBundle)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

// MARK: - Presentable
extension AlertViewController {
    var topViewController: UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }

    func present() {
        if let topViewController = topViewController {
            present(on: topViewController)
        }
    }

    func present(on viewController: UIViewController) {
        viewController.present(self, animated: true, completion: nil)
    }

    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UI
private extension AlertViewController {
    func setupUI() {
        generalSetupUI()
        setupTitle()
        setupContentStackView()
        setupActionsStackView()
    }

    func generalSetupUI() {
        corneredContainerView.layer.cornerRadius = 6
        corneredContainerView.layer.masksToBounds = true
        corneredContainerView.backgroundColor = .white

        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowColor = UIColor.black.withAlphaComponent(0.15).cgColor
        containerView.layer.shadowRadius = 10
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
    }

    func setupTitle() {
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleLabel.text = title1
    }

    func setupContentStackView() {
        if let contentView = contentView {
            contentStackView.addArrangedSubview(contentView)
        }
    }

    func setupActionsStackView() {
        let stackViewAxis = actions.count > 2
        actionStackView.axis = stackViewAxis ? .vertical : .horizontal

        let topSeparator = makeSeparator(isVertical: false)
        topSeparator.translatesAutoresizingMaskIntoConstraints = false
        corneredContainerView.addSubview(topSeparator)
        topSeparator.bottomAnchor.constraint(equalTo: actionStackView.topAnchor).isActive = true
        topSeparator.leadingAnchor.constraint(equalTo: corneredContainerView.leadingAnchor).isActive = true
        topSeparator.trailingAnchor.constraint(equalTo: corneredContainerView.trailingAnchor).isActive = true

        for i in 0 ..< actions.count {
            let action = actions[i]

            if i > 0  {
                actionStackView.addArrangedSubview(makeSeparator(isVertical: !stackViewAxis))
            }
            actionStackView.addArrangedSubview(makeButton(action: action, index: i))
        }
    }

    func makeButton(action: AlertViewAction, index: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(action.getTitle(), for: .normal)
        button.tag = index
        button.titleLabel?.font = makeActionFont(action: action)
        button.addTarget(self, action: #selector(alertActionDidTap), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        if actions.count == 2 {
            let width = (corneredContainerView.frame.width / 2.0) - 1.0
            button.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        return button
    }

    func makeActionFont(action: AlertViewAction) -> UIFont {
        switch action.getStyle() {
        case .default: return UIFont.systemFont(ofSize: 17, weight: .regular)
        case .cancel: return UIFont.systemFont(ofSize: 17, weight: .regular)
        case .done: return UIFont.systemFont(ofSize: 17, weight: .bold)
        }
    }

    func makeSeparator(isVertical: Bool) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        if isVertical {
            view.widthAnchor.constraint(equalToConstant: 1).isActive = true
        } else {
            view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        }
        return view
    }
}

// MARK: - Actions
private extension AlertViewController {
    @IBAction func alertActionDidTap(_ sender: UIButton) {
        dismiss()

        let action = actions[sender.tag]
        let actionCompletion = action.getAction()
        actionCompletion()
    }
}
