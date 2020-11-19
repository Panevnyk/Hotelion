//
//  DecimalFormatter.swift
//  Hotelion
//
//  Created by Vladyslav Panevnyk on 18.04.18.

//

import Foundation

struct DecimalFormatter: DoubleFormatter {
    var minimumFractionDigits = 0
    var maximumFractionDigits = 1
    
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.usesGroupingSeparator = false
        numberFormatter.decimalSeparator = Locale.current.decimalSeparator
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = minimumFractionDigits
        numberFormatter.maximumFractionDigits = maximumFractionDigits
        
        return numberFormatter
    }
    
    func format(_ value: Double) -> String {
        return numberFormatter.string(from: NSNumber(value: value)) ?? ""
    }
}
