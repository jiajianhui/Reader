//
//  Vibration.swift
//  Reader
//
//  Created by 贾建辉 on 2023/12/5.
//

import Foundation
import SwiftUI

enum Vibration {
    case error
    case success
    case light
    case selection
    
    func vibration() {
        switch self {
        case .error:
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        case .success:
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        case .light:
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        case .selection:
            UISelectionFeedbackGenerator().selectionChanged()
        }
    }
}
