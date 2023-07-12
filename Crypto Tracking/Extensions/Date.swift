//
//  Date.swift
//  Crypto Tracking
//
//  Created by M.Huzaifa on 7/10/23.
//

import Foundation

// "2021-03-13T20:49:26.606Z"
extension Date {
    
    init (coinGekoString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinGekoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func asShortDateString() -> String {
        return shortFormatter.string(from: self)
    }
}
