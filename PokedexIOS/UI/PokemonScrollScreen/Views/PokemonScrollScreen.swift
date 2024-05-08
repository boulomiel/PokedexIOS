//
//  PokemonScrllScreen.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation
import SwiftUI

public struct PokemonScrollScreen: View {
    
    @Environment(\.modelContext) var modelContext
    @DIContainer var scrollApi: ScrollFetchPokemonApi
    @DIContainer var fetchApi: FetchPokemonApi
    
    public var body: some View {
        PaginatedList(
            provider: .init(api: scrollApi, fetchApi: fetchApi, modelContainer: modelContext.container),
            scroller: { provider  in
                PokemonListScrolledContent(provider: provider)
            }
        )
    }
}

#Preview {
    @Environment(\.diContainer) var container
    
    return NavigationStack {
        PokemonScrollScreen()
    }
    .inject(container: container)
    .preferredColorScheme(.dark)
}
