//
//  PokeballView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import SwiftUI

public struct PokebalView: View {
    
    let radius: CGFloat
    @State private var appeared: Bool = false
    
    public var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.red)
                .frame(width: radius * 2, height: radius * 2)
                .clipShape(PokeBallTopShape())
            Rectangle()
                .fill(Color.white)
                .frame(width: radius * 2, height: radius * 2)
                .clipShape(PokeBallTopShape())
                .rotationEffect(.degrees(180))

        }
        .overlay {
            Circle()
                .fill(Color.white)
                .frame(width: radius / 2)
        }
        .keyframeAnimator(initialValue: Anim(),
                          trigger: appeared) { view, value in
            view
                .scaleEffect(value.scale)
                .rotationEffect(.degrees(value.rotation))
        } keyframes: { _ in
            KeyframeTrack(\.scale) {
                CubicKeyframe(0.5, duration: 0.2)
                SpringKeyframe(1.0, duration: 0.7)
            }
            KeyframeTrack(\.rotation) {
                CubicKeyframe(180, duration: 0.2)
                SpringKeyframe(0, duration: 0.7)
            }
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                appeared = true
            }
        })

    }
    
    public struct Anim {
        var rotation: Double = 0.0
        var scale: Double = 0.2
    }
}

#Preview {
    PokebalView(radius: 100)
        .preferredColorScheme(.dark)
}
