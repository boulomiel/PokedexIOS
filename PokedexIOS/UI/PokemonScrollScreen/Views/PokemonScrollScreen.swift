//
//  PokemonScrllScreen.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation
import SwiftUI
import DI

public struct PokemonScrollScreen: View {
    
    @Environment(\.modelContext) var modelContext
    @DIContainer var scrollApi: ScrollFetchPokemonApi
    @DIContainer var fetchApi: FetchPokemonApi
    @DIContainer var languageNameFetcher: LanguageNameFetcher
    
    public var body: some View {
        PaginatedList(
            provider: .init(api: scrollApi, fetchApi: fetchApi, modelContainer: modelContext.container, languageNameFetcher: languageNameFetcher),
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
