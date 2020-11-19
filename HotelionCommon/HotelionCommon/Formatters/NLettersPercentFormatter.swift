//
//  NLettersPercentFormatter.swift
//  Hotelion
//
//  Created by Panevnyk Vlad on 1/16/20.

//

import Foundation

struct NLettersPercentFormatter: DoubleFormatter {
    var lettersCount = 0
    var minimumFractionDigits = 0
    var maximumFractionDigits = 0
    
    func format(_ value: Double) -> String {
        var value = value
        
        if value < 0 {
            value = 0
        } else if value > 100 {
            value = 100
        }
        
        let numFormatter = NumberFormatter()
        numFormatter.allowsFloats = true
        numFormatter.minimumIntegerDigits = 1
        numFormatter.minimumFractionDigits = 0
        numFormatter.maximumFractionDigits = maximumFractionDigits
        
        var res = numFormatter.string(from: NSNumber(value: value)) ?? ""
        res += (value == 0 ? "" : "%")
        if lettersCount > res.count {
            res = String(repeating: " ", count: lettersCount - res.count) + res
        }
        
        return res
    }
}
