//
//  PokemonBeltView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import SwiftUI

struct PokeBallBeltView<Content: View>: View {
    
    let selectedPokemons: [Pokemon]
    @State private var showPokemon: Pokemon?
    @Namespace var showPokemonId
    var onShowPokemon: (Pokemon?) -> Void
    var onRemovePokemon: ((Pokemon?) -> Void)
    @ViewBuilder var buildTeamButton: Content
    
    var body: some View {
        VStack {
            if showPokemon != nil {
                ScaleAsyncImage(url: showPokemon?.sprites?.frontDefault, width: 300, height: 300)
                    .background(Color.gray.opacity(0.3))
                    .clipShape(Circle())
                    .overlay(alignment: .topTrailing, content: {
                        Image(systemName: "xmark")
                            .padding()
                            .background(Circle().fill(Color.gray.opacity(0.8)))
                    })
                    .matchedGeometryEffect(id: showPokemon!, in: showPokemonId)
                    .onTapGesture {
                        withAnimation {
                            showPokemon = nil
                        }
                    }
                    .transition(.scale)
            } else {
                ZStack {
                    if !selectedPokemons.isEmpty {
                        Color
                            .gray
                            .opacity(0.5)
                            .frame(height: 45)
                    }
                    HStack {
                        ForEach(selectedPokemons, id: \.id) { pokemon in
                            Button(action: {
                                withAnimation {
                                    showPokemon = pokemon
                                }
                                onShowPokemon(pokemon)

                            }, label: {
                                PokebalView(radius: 24)
                                    .contentShape(Circle())
                                    .contextMenu(ContextMenu(menuItems: {
                                        Button(role: .destructive){
                                            onRemovePokemon(pokemon)
                                        } label: {
                                            Label("Remove from team", systemImage: "trash")
                                        }
                                    }))
                            })
                            .matchedGeometryEffect(id: pokemon, in: showPokemonId)
                        }
                        if selectedPokemons.count == 6 {
                            buildTeamButton
                        }
                    }
                }
            }
        }
    }
}

extension View {
    
    @ViewBuilder
    func wrappedInScroll(_ isWrapped: Bool, axis: Axis.Set) -> some View {
        if isWrapped {
            ScrollView(axis) {
                self
            }
        } else {
            self
        }
    }
}

#Preview {
    @Environment(\.diContainer) var container
    
    return PokeBallBeltView(selectedPokemons: JsonReader.readPokemons(), onShowPokemon: { _ in }, onRemovePokemon: {_ in }, buildTeamButton: {
        Text("Build Team")
    })
        .inject(container: container)
        .preferredColorScheme(.dark)
}
