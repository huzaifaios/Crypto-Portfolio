//
//  Double.swift
//  Crypto Tracking
//
//  Created by M.Huzaifa on 6/26/23.
//

import Foundation

extension Double {
    
    /// Converts a Double into a Currency with 2 decimal places
    /// ```
    /// Convert 1234.56 into $1,234.56
    /// ```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    /// Converts a Double into a Currency  as a String with 2-6 decimal places
    /// ```
    /// Convert 1234.56 into "$1,234.56"
    /// ```
    func asCurrencyWith2Decimal() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.000"
    }
    /// Converts a Double into a Currency with 2-6 decimal places
    /// ```
    /// Convert 1234.56 into $1,234.56
    /// Convert 12.3456 into $12.3456
    /// Convert 0.123456 into $0.123456
    /// ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// Converts a Double into a Currency  as a String with 2-6 decimal places
    /// ```
    /// Convert 1234.56 into "$1,234.56"
    /// Convert 12.3456 into "$12.3456"
    /// Convert 0.123456 into "$0.123456"
    /// ```
    func asCurrencyWith6Decimal() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.000"
    }
    /// Converts a Double into a String representation
    /// ```
    /// Convert 1.23456 into "1.23"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
    
    ///Convert a Double to a String with K, M, Bn, Tr abbrevation
    ///```
    ///Convert 12 to 12.00
    ///Convert 1234 to 1.23K
    ///Convert 123456 to 123.45K
    ///Convert 12345678 to 12.34M
    ///Convert 1234567890 to 1.23Bn
    ///Convert 123456789012 to 123.45Bn
    ///Convert 12345678901234 to 12.34Tr
    ///```
    func formattedWithAbbrevations () -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""
        
        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()
        default:
            return "\(sign)\(self))"
        }
    }
    
}
