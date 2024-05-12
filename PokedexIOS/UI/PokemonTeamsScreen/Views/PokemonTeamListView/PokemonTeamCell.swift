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
import Dtos
import SwiftData

public struct PokemonTeamCell: View {
    
    @State var provider: Provider
    @Environment(TeamRouter.self) var teamRouter
    
    private let grid: [GridItem] = Array(repeating: .init(.flexible(minimum: 120)), count: 3)
    
    public var body: some View {
        LazyVGrid(columns: grid, content: {
            ForEach(provider.providers, id: \.pokemonID) { provider in
                Cell(provider: provider)
            }
            .contextMenu(ContextMenu(menuItems: {
                Button(action: {
                    teamRouter.sharingSheet(ShareTeamRoute(teamID: provider.team.persistentModelID))
                }, label: {
                    Label("Share team", systemImage: "square.and.arrow.up")
                })
            }))
        })
        .frame(height: 280)
    }
    
    @Observable
    class Provider {

        let team: SDTeam
        
        var providers: [Cell.Provider] {
            team.pokemons?.compactMap { .init(sdPokemon: $0) } ?? []
        }
        
        init(team: SDTeam) {
            self.team = team
        }
    }
    
    struct Cell: View {
        
        @Environment(TeamRouter.self)
        private var teamRouter
        
        let provider: Provider
        
        var body: some View {
            if let decoded = provider.pokemon {
                VStack {
                    ScaleAsyncImage(url: decoded.sprites?.frontDefault, width: 80, height: 80)
                    Text(decoded.name.capitalized)
                        .bold()
                        .foregroundStyle(.white)
                }
                .overlay(alignment: .topTrailing, content: {
                    if let item = provider.item {
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
                    teamRouter.root(as: PreviewRoute(pokemonID: provider.pokemonID))
                }
            } else {
                ProgressView()
            }
        }
        
        @Observable
        class Provider: Identifiable {
            let id: UUID = .init()
            
            var pokemon: Pokemon?
            var item: Item?

            let pokemonID: PersistentIdentifier
            
            init(sdPokemon: SDPokemon) {
                pokemonID = sdPokemon.persistentModelID
                Task {
                    await decode(sdPokemon: sdPokemon)
                }
                Task {
                    await decode(sdItem: sdPokemon.item)
                }
            }
            
            @MainActor
            func decode(sdPokemon: SDPokemon) async {
                self.pokemon = await sdPokemon.decodedAsync()
            }
            
            @MainActor
            func decode(sdItem: SDItem?) async {
                self.item = await sdItem?.decodedAsync()
            }
        }
    }
}

#Preview {
    @Environment(\.diContainer) var container
    let preview = Preview(SDMove.self, SDPokemon.self, SDItem.self, SDTeam.self)
    
    let pokemons = JsonReader.readPokemons().map { SDPokemon(pokemonID: $0.id, data: try! JSONEncoder().encode($0)) }
    let team = SDTeam(teamID: .init(), name: "Test2")
    team.pokemons = pokemons
    preview.addExamples([team])
    return PokemonTeamCell(provider: .init(team: team))
        .environment(TeamRouter())
        .modelContainer(preview.container)
        .inject(container: container)
}
