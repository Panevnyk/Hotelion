//
//  AbbrevationFormatter.swift
//  Hotelion
//
//  Created by Panevnyk Vlad on 1/23/20.

//

struct AbbrevationFormatter: DoubleFormatter {
    var minimumFractionDigits = 0
    var maximumFractionDigits = 0
    
    func format(_ value: Double) -> String {
        return ""//value.formatUsingAbbrevation(minimumFractionDigits: minimumFractionDigits, maximumFractionDigits: maximumFractionDigits)
    }
}
