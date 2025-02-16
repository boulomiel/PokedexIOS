//
//  PokemonScrollCell.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation
import SwiftUI
import DI
import Dtos

public struct PokemonScrollCell: View {
    
    @State var provider: Provider
    
    public var body: some View {

        HStack {
            Text(provider.pokemonName)
                .bold()
                .font(.title2)
                .foregroundStyle(.white)
                .padding(.leading)
            
            Spacer()
            
            Circle()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 100, height: 100)
                .overlay {
                    PokeballImageAsync(url: provider.sprite, width: 100, height: 100)
                }
                .padding(.trailing)
        }
        .padding(.vertical)
        .background {
            NavigationLink(value: provider.pokemon) {
            }
            .opacity(0.0)
        }
        .pokemonTypeBackgroundH(types: provider.types)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    @Observable @MainActor
    public final class Provider {
        
        let api: FetchPokemonApi
        let speciesApi: PokemonSpeciesApi
        var pokemon: LocalPokemon
        
        var names: [String: String]
        var sprite: URL?
        var types: [PokemonType.PT]
        var languageName: LanguageName
        
        var pokemonName: String {
            if case .en(let englishName) = languageName {
                return englishName.capitalized
            } else {
                return languageName.foreign.capitalized
            }
        }
        
        init(api: FetchPokemonApi, speciesApi: PokemonSpeciesApi, pokemon: LocalPokemon) {
            self.api = api
            self.speciesApi = speciesApi
            self.pokemon = pokemon
            self.names = [:]
            self.types = []
            self.languageName = .en(englishName: pokemon.name)
            Task {
                await fetch()
            }
        }
        
        init(
            api: FetchPokemonApi,
            speciesApi: PokemonSpeciesApi,
            pokemon: LocalPokemon,
            sprite: URL?,
            types:[PokemonType.PT]?,
            languageName: LanguageName
        ) {
            self.api = api
            self.speciesApi = speciesApi
            self.pokemon = pokemon
            self.names = [:]
            self.sprite = sprite
            self.languageName = languageName
            self.types = types ?? []
        }
        
        private func fetch() async {
            let result = await api.fetch(id: pokemon.name)
            switch result {
            case .success(let result):
                withAnimation(.smooth) {
                    types = result.types.pt
                    sprite = result.sprites?.frontDefault
                }
            case .failure(let error):
                print(#file, #function, error)
            }
        }
        
        private func fetchSpecies(_ species: String) async {
            let result = await speciesApi.fetch(query: .init(speciesNumber: species))
            switch result {
            case .success(let result):
                let names = result.names.map {
                    ($0.language.name, $0.name)
                }
                self.names = Dictionary.init(names) { first, second in
                    first
                }
            case .failure(let error):
                print(#file, #function, error)
            }
        }
    }
    
    public struct Name {
        let language: String
        let name: String
    }
}


#Preview {
    @Previewable @Environment(\.diContainer) var container
    
    NavigationStack {
        List {
            PokemonScrollCell(provider: .init(api: .init(), speciesApi: .init(), pokemon: .init(index: 25, name: "pikachu")))
                .inject(container: container)
                .preferredColorScheme(.dark)
        }
    }
}
