//
//  Vibrator.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 26/04/2024.
//

import Foundation
import CoreHaptics
import UIKit

struct Vibrator {
    static func selection() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
    
    static func notify(of event: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(event)
    }
    
    static func change(of event: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: event)
        generator.impactOccurred()
    }
}
