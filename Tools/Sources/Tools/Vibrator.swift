//
//  Vibrator.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 26/04/2024.
//

import Foundation
import CoreHaptics
import UIKit

@MainActor
public struct Vibrator {
    public static func selection() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
    
    public static func notify(of event: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(event)
    }
    
    public static func change(of event: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: event)
        generator.impactOccurred()
    }
}
