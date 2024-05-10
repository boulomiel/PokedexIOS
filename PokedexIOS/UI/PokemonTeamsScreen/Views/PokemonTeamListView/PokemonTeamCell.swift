//
//  PokemonTeamCell.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import SwiftUI
import Resources
import Tools
import DI

public struct PokemonTeamCell: View {
    
    let team: SDTeam
    @Environment(TeamRouter.self) var teamRouter
    
    private var pokemons: [SDPokemon] {
        team.pokemons?.sorted(by: { $0.pokemonID < $1.pokemonID }) ?? []
    }
        
    private let grid: [GridItem] = Array(repeating: .init(.flexible(minimum: 120)), count: 3)
    
    public var body: some View {
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
                    .background {
                        ZStack {
                            Spacer()
                        }
                        .frame(width: 80, height: 80, alignment: .leading)
                        .pokemonTypeBackgroundCircle(types: decoded.types.pt)
                        .clipShape(Circle())
                    }
                    .onTapGesture {
                        teamRouter.root(as: PreviewRoute(pokemonID: pokemon.persistentModelID))
                    }
                } else {
                    ProgressView()
                }
            }
            .contextMenu(ContextMenu(menuItems: {
                Button(action: {
                    teamRouter.sharingSheet(ShareTeamRoute(teamID: team.persistentModelID))
                }, label: {
                    Label("Share team", systemImage: "square.and.arrow.up")
                })
            }))
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
