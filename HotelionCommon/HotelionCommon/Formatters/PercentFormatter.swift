//
//  PercentFormatter.swift
//  Hotelion
//
//  Created by Panevnyk Vlad on 1/16/20.

//

import Foundation

struct PercentFormatter: DoubleFormatter {
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
        numFormatter.minimumFractionDigits = minimumFractionDigits
        numFormatter.maximumFractionDigits = maximumFractionDigits
        
        let res = numFormatter.string(from: NSNumber(value: value)) ?? ""
    
        return res + "%"
    }
}
