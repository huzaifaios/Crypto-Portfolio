//
//  UIApplication.swift
//  Crypto Tracking
//
//  Created by M.Huzaifa on 7/5/23.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEdititng() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
