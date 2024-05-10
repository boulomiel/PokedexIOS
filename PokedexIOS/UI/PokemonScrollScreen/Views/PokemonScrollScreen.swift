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
    
    @Environment(\.modelContext)
    private var modelContext
    @DIContainer private var scrollApi: ScrollFetchPokemonApi
    @DIContainer private var fetchApi: FetchPokemonApi
    @DIContainer private var languageNameFetcher: LanguageNameFetcher
    
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
