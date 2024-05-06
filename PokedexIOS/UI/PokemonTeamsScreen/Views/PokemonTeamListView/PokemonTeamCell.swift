//
//  PokemonTeamCell.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import SwiftUI

struct PokemonTeamCell: View {
    
    var team: SDTeam
    @Environment(TeamRouter.self) var teamRouter
    
    private var pokemons: [SDPokemon] {
        team.pokemons?.sorted(by: { $0.pokemonID < $1.pokemonID }) ?? []
    }
    private let grid: [GridItem] = Array(repeating: .init(.fixed(120)), count: 3)
    
    var body: some View {
        LazyVGrid(columns: grid, content: {
            ForEach(pokemons, id: \.id) { pokemon in
                if let decoded = pokemon.decoded {
                    VStack {
                        ScaleAsyncImage(url: decoded.sprites?.frontDefault, width: 80, height: 80)
                        Text(decoded.name.capitalized)
                            .bold()
                            .foregroundStyle(.white)
                    }
                    .overlay(alignment: .topTrailing, content: {
                        if let item = pokemon.item?.decoded {
                            Circle()
                                .fill(.ultraThinMaterial)
                                .frame(width: 30)
                                .overlay {
                                    ScaleAsyncImage(url: item.sprites.defaultSprite, width: 30, height: 30)
                                }
                        }
                    })
                    .onTapGesture {
                        teamRouter.root(as: PreviewRoute(pokemonID: pokemon.persistentModelID))
                    }
                } else {
                    Text("Cant decode")
                }
            }
        })
    }
}

#Preview {
    @Environment(\.diContainer) var container
    let preview = Preview(SDMove.self, SDPokemon.self, SDItem.self, SDTeam.self)
    
    let pokemons = JsonReader.readPokemons().map { SDPokemon(pokemonID: $0.id, data: try! JSONEncoder().encode($0)) }
    let team = SDTeam(teamID: .init(), name: "Test2")
    team.pokemons = pokemons
    preview.addExamples([team])
    return PokemonTeamCell(team: team)
        .environment(TeamRouter())
        .modelContainer(preview.container)
        .inject(container: container)
}
