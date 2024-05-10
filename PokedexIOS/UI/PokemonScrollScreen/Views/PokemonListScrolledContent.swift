//
//  PokemonListScrolledContent.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import Foundation
import SwiftUI
import DI
import Dtos

public struct PokemonListScrolledContent: View {
    
    typealias Provider = PaginatedList<Self, ScrollFetchPokemonApi, FetchPokemonApi>.Provider
    @DIContainer var speciesApi: PokemonSpeciesApi
    @Bindable var provider: Provider
    
    public var body: some View {
        content
    }
    
    var content: some View {
        List {
            listContent
        }
        .scrollContentBackground(.hidden)

    }
    
    var forEach: some View {
        ForEach(provider.config.list, id: \.0) { (index, pokemon) in
            PokemonScrollCell(provider: .init(api: provider.fetchApi, speciesApi: speciesApi, pokemon: .init(index: index+1, name: pokemon.name)))
                .onAppear {
                    provider.update(from: index)
                }
                .id(pokemon.name)
                .listRowBackground(Color.clear)

        }
    }
    
    func searchedList(_ searched: [Provider.SearchedElement<Pokemon>]) -> some View {
        ForEach(Array(searched.enumerated()), id:\.offset) { offset, pokemon in
            PokemonScrollCell(provider: .init(api: provider.fetchApi, speciesApi: speciesApi, pokemon: .init(index: pokemon.element.order, name: pokemon.element.name),sprite: pokemon.element.sprites?.frontDefault,types: pokemon.element.types.pt, languageName: pokemon.language))
                .onAppear {
                    provider.update(from: offset)
                }
                .id(pokemon.language.english)
                .listRowBackground(Color.clear)
        }
    }
    
    @ViewBuilder
    var listContent: some View {
        if let fetched = provider.searched {
            searchedList(fetched)
        } else {
            forEach
        }
    }
}

#Preview {
    @Environment(\.diContainer) var container
    return  NavigationStack {
        PokemonScrollScreen()
            .inject(container: container)
            .preferredColorScheme(.dark)
    }
}
