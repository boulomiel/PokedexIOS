//
//  PokemonListScrolledContent.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import Foundation
import SwiftUI

struct PokemonListScrolledContent: View {
    
    typealias Provider = PaginatedList<Self, ScrollFetchPokemonApi, FetchPokemonApi>.Provider
    @DIContainer var speciesApi: PokemonSpeciesApi
    @Bindable var provider: Provider
    
    var body: some View {
        content
    }
    
    var content: some View {
        List {
            listContent
        }
    }
    
    var forEach: some View {
        ForEach(provider.config.list, id: \.0) { (index, pokemon) in
            PokemonScrollCell(provider: .init(api: provider.fetchApi, speciesApi: speciesApi, pokemon: .init(index: index+1, name: pokemon.name)))
                .onAppear {
                    provider.update(from: index)
                }
                .id(pokemon.name)
        }
    }
    
    @ViewBuilder
    var listContent: some View {
        if let fetched = provider.searched {
            PokemonScrollCell(provider: .init(api: provider.fetchApi, speciesApi: .init(), pokemon: .init(index: fetched.order, name: fetched.name)))
                .id(fetched.name)
        } else {
            forEach
        }
    }
}

#Preview {
    @Environment(\.container) var container
    return  NavigationStack {
        PokemonScrollScreen()
            .inject(container: container)
            .preferredColorScheme(.dark)
    }
}
