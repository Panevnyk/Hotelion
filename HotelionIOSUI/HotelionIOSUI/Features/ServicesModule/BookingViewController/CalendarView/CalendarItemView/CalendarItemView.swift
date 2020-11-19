//
//  CalendarViewItem.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 24.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit

final class CalendarItemView: UICollectionViewCell {
    // MARK: - Properties
    @IBOutlet private var dayLabel: UILabel!
    @IBOutlet private var hourLabel: UILabel!
    @IBOutlet private var monthLabel: UILabel!
    @IBOutlet private var corneredView: UIView!
    @IBOutlet private var separatorView: UIView!

    // MARK: - Inits
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }

    private func initialize() {
        corneredView.layer.cornerRadius = 4
        corneredView.layer.masksToBounds = true
    }

    func fill(viewModel: CalendarItemViewModel) {
        isHidden = viewModel.isEmpty
        guard !viewModel.isEmpty else { return }

        dayLabel.text = viewModel.displayDay
        monthLabel.text = viewModel.displayMonth
        hourLabel.text = viewModel.displayHour

        let backgroundColor: UIColor
        let dayTextColor: UIColor
        if viewModel.isAvailable {
            if viewModel.selectedEvents.count > 0 {
                backgroundColor = .systemBlue
                dayTextColor = .white
            } else {
                backgroundColor = .white
                dayTextColor = .black
            }
        } else {
            backgroundColor = .white
            dayTextColor = .lightGray
        }
        
        corneredView.backgroundColor =  backgroundColor
        dayLabel.textColor = dayTextColor
    }
}
