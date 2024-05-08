//
//  MutableModifier.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 01/05/2024.
//

import Foundation
import SwiftUI
import Tools
import DI

public struct MutableModifier: ViewModifier {
    
    @DIContainer var player: CriePlayer
    
    public func body(content: Content) -> some View {
        content
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        player.isMuted.toggle()
                    } label: {
                        Image(systemName: player.isMuted ? "speaker.fill" : "speaker.slash.fill")
                            .foregroundStyle(Color.white)
                    }
                    .animation(.smooth) { view in
                        let isMuted = player.isMuted
                        return view
                            .scaleEffect(isMuted ? 1 : 0.8)
                            .opacity(isMuted ? 1 : 0.8)
                    }

                }
            })
    }
}

public extension View {
    
    func showMutableIcon() -> some View {
        modifier(MutableModifier())
    }
}
