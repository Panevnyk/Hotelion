//
//  SUDateTextField.swift
//  HotelionCommon
//
//  Created by Vladyslav Panevnyk on 27.01.2021.
//

import UIKit
import RxSwift
import RxCocoa

public class SUDateTextField: SUTextField {
    // MARK: - Properties
    // UI
    private(set) var datePicker = UIDatePicker()

    // Formatter
    private(set) var dateFormatter = DateHelper.shared.dateStyleFormatter

    // MARK: - Initialize
    public override func initialize() {
        super.initialize()

        config = .name

        setupUI()
        addDoneAccessoryView()
    }

    // MARK: - SetupUI
    private func setupUI() {
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.date = DateHelper.shared.utcCalendar.startOfDay(for: Date())
        datePicker.datePickerMode = .date
        datePicker.timeZone = DateHelper.shared.utcTimeZone
        datePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)

        textField.inputView = datePicker
    }

    private func addDoneAccessoryView() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 44))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.items = [spaceButton, doneButton]
        toolBar.tintColor = .kViolet
        textField.inputAccessoryView = toolBar
    }

    // MARK: - Public methods
    public func setDate(_ date: Date) {
        datePicker.date = date
        timeChanged(datePicker)
    }

    public func setMinimumDate(_ date: Date?) {
        datePicker.minimumDate = date
        timeChanged(datePicker)
    }
}

// MARK: - Actions
private extension SUDateTextField {
    @IBAction func timeChanged(_ sender: UIDatePicker) {
        let date = sender.date
        textField.text = dateFormatter.string(from: date)
        textField.sendActions(for: .valueChanged)
    }

    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        endEditing(true)
    }
}
