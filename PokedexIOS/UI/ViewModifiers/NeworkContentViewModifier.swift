//
//  NeworkContentViewModifier.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 03/05/2024.
//

import Foundation
import SwiftUI

struct NetworkContentViewModifier: ViewModifier {
    
    @DIContainer var networkManager: NetworkManager
    
    func body(content: Content) -> some View {
        if networkManager.status.showContent {
            content
        } else {
           ContentUnavailableView("No network access", systemImage: "network.slash", description: Text("In order to reach Dr. Oaks pokemon data base the pokedex must have a network access. Please check your connection."))
        }
    }
}

extension View {
    func networkedContentView() -> some View {
        modifier(NetworkContentViewModifier())
    }
}
