//
//  PokemonScrollCell.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation
import SwiftUI

struct PokemonScrollCell: View {
    
    @State var provider: Provider
    
    var body: some View {
        NavigationLink(value: provider.pokemon) {
            GroupBox {
                HStack {
                    Text(provider.pokemon.name.capitalized)
                        .bold()
                        .font(.title2)
                    
                    Spacer()
                
                    Circle()
                        .fill(Color.gray.opacity(0.1))
                        .frame(width: 100, height: 100)
                        .overlay {
                            PokeballImageAsync(url: provider.sprite, width: 100, height: 100)
                        }
                }
            }
        }
    }
    
    @Observable
    class Provider {
        
        let api: FetchPokemonApi
        let speciesApi: PokemonSpeciesApi
        var pokemon: LocalPokemon
        var sprite: URL?
        var names: [String: String]
        
        init(api: FetchPokemonApi, speciesApi: PokemonSpeciesApi, pokemon: LocalPokemon) {
            self.api = api
            self.speciesApi = speciesApi
            self.pokemon = pokemon
            self.names = [:]
            Task {
                await fetch()
            }
        }
        
        private func fetch() async {
            let result = await api.fetch(query: .init(pokemonID: pokemon.name))
            switch result {
            case .success(let result):
                Task {
                    await fetchSpecies(result.name)
                }
                await MainActor.run {
                    sprite = result.sprites?.frontDefault
                }
            case .failure(let error):
                print(#function, error)
            }
        }
        
        private func fetchSpecies(_ species: String) async {
            let result = await speciesApi.fetch(query: .init(speciesNumber: species))
            switch result {
            case .success(let result):
                let names = result.names.map {
                    ($0.language.name, $0.name)
                }
                await MainActor.run {
                    self.names = Dictionary.init(names) { first, second in
                        first
                    }
                    print(#function, names)
                }
            case .failure(let error):
                print(#function, error)
            }
        }
    }
    
    struct Name {
        let language: String
        let name: String
    }
}


#Preview {
    @Environment(\.container) var container
    
    return PokemonScrollCell(provider: .init(api: .init(), speciesApi: .init(), pokemon: .init(index: 25, name: "pikachu")))
        .inject(container: container)
        .preferredColorScheme(.dark)
}
