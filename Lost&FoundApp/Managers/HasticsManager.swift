//
//  HapticsManager.swift
//  Thoughts
//
//  Created by Aibatyr on 8/6/21.
//

import Foundation
import UIKit

class LFHapticsManager {
    static let shared = LFHapticsManager()

    private init() {}

    func vibrateForSelection() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }

    func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
}
