//
//  String.swift
//  Crypto Tracking
//
//  Created by M.Huzaifa on 7/11/23.
//

import Foundation

extension String {
    
    var removeHTMLOccurences: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
