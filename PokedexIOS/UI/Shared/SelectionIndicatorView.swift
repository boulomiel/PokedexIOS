//
//  SelectionIndicator.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 01/05/2024.
//

import SwiftUI

public struct SelectionIndicatorView: View {
    
    @Binding var isSelected: Bool
    
    public var body: some View {
        Image(systemName: isSelected ? "checkmark.circle" : "circle")
            .foregroundStyle(isSelected ? Color.blue : Color.gray.opacity(0.3))
            .keyframeAnimator(initialValue: Anim(scale: 1.0), trigger: isSelected, content: { view, value in
                view
                    .scaleEffect(value.scale)
            }, keyframes: { _ in
                KeyframeTrack(\.scale) {
                    CubicKeyframe(0.8, duration: 0.2)
                    SpringKeyframe(1.0, duration: 0.1)
                }
            })
            .foregroundStyle( isSelected ? .blue : Color.gray.opacity(0.3))
    }
    
    public struct Anim {
        var scale: Double
        var color: Color =  Color.gray.opacity(0.3)
    }
}

#Preview {
    SelectionIndicatorView(isSelected: .constant(true))
        .preferredColorScheme(.dark)
}
