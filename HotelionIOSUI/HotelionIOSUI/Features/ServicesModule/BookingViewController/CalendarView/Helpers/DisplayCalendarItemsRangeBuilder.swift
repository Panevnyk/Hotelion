//
//  DisplayCalendarItemsRangeBuilder.swift
//  HotelionIOSUI
//
//  Created by Vladyslav Panevnyk on 25.09.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation


final class DisplayCalendarItemsRangeBuilder {
    func makeDisplayCalendarItemsRange(startDate: Date,
                                       endDate: Date,
                                       itemViewModels: [CalendarItemViewModel]
    ) -> [CalendarItemViewModel] {
        var displayCalendarItems: [CalendarItemViewModel] = []

        var index: Int = 0
        for i in 0 ..< itemViewModels.count {
            let itemViewModel = itemViewModels[i]

            if itemViewModel.date.isFirstDayOfMonth && i != 0 {
                for _ in 0 ..< 7 {
                    displayCalendarItems.append(CalendarItemViewModel.makeIsEmpty(index: index))

                    index += 1
                }
            }

            itemViewModel.updateIndex(to: index)
            displayCalendarItems.append(itemViewModel)

            index += 1
        }

        return displayCalendarItems
    }
}
