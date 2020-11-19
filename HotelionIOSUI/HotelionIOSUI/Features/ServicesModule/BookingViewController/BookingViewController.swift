//
//  CalendarViewController.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 29.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit

public final class BookingViewController: UIViewController, BookingViewModelOutput {
    // MARK: - Properties
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var calendarView: CalendarView!

    public var viewModel: BookingViewModelProtocol!

    // MARK: - Life cycle
    public override func viewDidLoad() {
        super.viewDidLoad()

        calendarView.viewModel = viewModel.getCalendarViewModel()
        calendarView.viewModel.output = calendarView
        setupUI()
        bind()
    }
}

// MARK: - Bind
private extension BookingViewController {
    func bind() {
        titleLabel.text = viewModel.getTitle()
    }
}

// MARK: - UI
private extension BookingViewController {
    func setupUI() {
        doneButton.setTitle("Done", for: .normal)
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        doneButton.addTarget(self, action: #selector(doneAction), for: .touchUpInside)

        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.textColor = .black
    }
}

// MARK: - Actions
private extension BookingViewController {
    @IBAction func doneAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
