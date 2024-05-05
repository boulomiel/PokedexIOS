//
//  PokemonScrllScreen.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation
import SwiftUI

struct PokemonScrollScreen: View {
    
    @DIContainer var scrollApi: ScrollFetchPokemonApi
    @DIContainer var fetchApi: FetchPokemonApi
    
    var body: some View {
        PaginatedList(
            provider: .init(api: scrollApi, fetchApi: fetchApi),
            scroller: { provider  in
                PokemonListScrolledContent(provider: provider)
            }
        )
    }
}

#Preview {
    @Environment(\.container) var container
    
    return NavigationStack {
        PokemonScrollScreen()
    }
    .inject(container: container)
    .preferredColorScheme(.dark)
}
