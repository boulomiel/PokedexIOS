//
//  EvolutionListViewCell.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 20/04/2024.
//

import Foundation
import SwiftUI
import DI

public struct EvolutionListViewCell: View {
    
    @Environment(PokemonDetailsProvider.self) var parent
    @Bindable var provider: Provider
    @State var url: URL?
    
    var link: LocalPokemon? {
        parent.localPokemon.name != provider.pokemon.name ? provider.pokemon : nil
    }
    
    public var body: some View {
        NavigationLink(value: link) {
            VStack(spacing: 8) {
                if let imageUrl = provider.genModels.first(where: { parent.segmentProvider?.selected == $0 })?.sprite?.frontDefault ?? provider.sprite {
                    ScaleAsyncImage(url: imageUrl, width: 100, height: 100)
                }
                
                ShrinkText(text: provider.pokemon.name.capitalized, alignment: .center, font: .caption.bold())
            }
            .frame(width: 120, height: 120)
            .padding(.bottom, 8)
            .background(shape.fill(Color.white.opacity(0.3)))
        }
        .foregroundStyle(.white)        
    }
    
    var shape: some Shape {
        RoundedRectangle(cornerRadius: 8)
    }
    
    @Observable @MainActor
   public class Provider: Identifiable {
        
        public let id: UUID = .init()
        let api: FetchPokemonApi
        var pokemon: LocalPokemon
        var sprite: URL?
        var genModels: [GenModel]
        
        init(api: FetchPokemonApi, pokemon: LocalPokemon) {
            self.api = api
            self.pokemon = pokemon
            self.genModels = []
            Task {
                await fetch()
            }
        }
        
        func fetch() async {
            let result = await api.fetch(query:.init(pokemonID: pokemon.name))
            switch result {
            case .success(let result):
                sprite = result.sprites?.frontDefault
                genModels = GenModel.generate(from: result)
            case .failure(let error):
                print(#file, #function, error)
            }
        }

    }
}

#Preview {
    @Previewable @Environment(
        \.diContainer
    ) var container
    return EvolutionListViewCell(
        provider: .init(
            api: .init(),
            pokemon: .init(
                index: 25,
                name: "pikachu"
            )
        )
    )
    .inject(
        container: container
    )
    .environment(
        PokemonDetailsProvider(
            api: .init(),
            speciesApi: .init(),
            evolutionChainApi: .init(),
            abilitiesApi: .init(),
            localPokemon: .init(
                index: 25,
                name: "pikachu"
            ),
            player: .init()
        )
    )
    .preferredColorScheme(
        .dark
    )

}
