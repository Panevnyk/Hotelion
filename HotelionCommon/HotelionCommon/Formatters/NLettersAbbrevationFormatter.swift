//
//  AbbrevationFormatter.swift
//  Hotelion
//
//  Created by Panevnyk Vlad on 1/19/20.

//

struct NLettersAbbrevationFormatter: DoubleFormatter {
    var lettersCount = 0
    var minimumFractionDigits = 0
    var maximumFractionDigits = 0
    
    func format(_ value: Double) -> String {
        var res = ""//value.formatUsingAbbrevation(minimumFractionDigits: minimumFractionDigits, maximumFractionDigits: maximumFractionDigits)
        
        if lettersCount > res.count {
            res = String(repeating: " ", count: lettersCount - res.count) + res
        }
        
        return res
    }
}
