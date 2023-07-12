//
//  HapticManager.swift
//  Crypto Tracking
//
//  Created by M.Huzaifa on 7/7/23.
//

import Foundation
import SwiftUI

class HapticManager {
    static let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
