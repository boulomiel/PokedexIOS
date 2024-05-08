//
//  PokemonGridCell.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import SwiftUI

public struct PokemonGridCell: View {
    
    let provider: Provider
    
    public var body: some View {
        NavigationLink(value: LocalPokemon(index: provider.number ?? -1, name: provider.pokemon)) {
            VStack {
                ScaleAsyncImage(url: provider.sprite, width: 100, height: 100)

                Text(pokemonName)
                    .frame(maxWidth: .infinity)
                    .minimumScaleFactor(0.6)
                    .lineLimit(1)
                    .layoutPriority(1)
                    .bold()
                    .foregroundStyle(.white)
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(shape.fill(Color.white.opacity(0.2)))
        }
    }
    
    var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 4)
    }
    
    var pokemonName: String {
        if let index = provider.number {
            return provider.pokemon.capitalized.appending(" #\(index)")
        } else {
            return provider.pokemon.capitalized
        }
    }
    
    @Observable
   public class Provider: Identifiable {
        public let id: UUID = .init()
        var sprite: URL?
        var number: Int?
        let pokemon: String
        let fechPokemonApi: FetchPokemonApi
        
        init(pokemon: String, fechPokemonApi: FetchPokemonApi) {
            self.pokemon = pokemon
            self.fechPokemonApi = fechPokemonApi
            Task {
                await fetch()
            }
        }
        
        private func fetch() async {
            let result = await fechPokemonApi.fetch(query: .init(pokemonID: pokemon))
            switch result {
            case .success(let success):
                await MainActor.run {
                    self.sprite = success.sprites?.frontDefault
                    self.number = success.id
                }
            case .failure(let failure):
                print(#file, #function, failure)
            }
        }
    }
}

#Preview {
    @Environment(\.diContainer) var container
    
    return PokemonGridCell(provider: .init(pokemon: "gengar", fechPokemonApi: .init()))
        .inject(container: container)
        .preferredColorScheme(.dark)
}


