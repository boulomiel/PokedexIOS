//
//  PokemonBeltView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import SwiftUI

struct PokeBallBeltView: View {
    
    let selectedPokemons: [Pokemon]
    @State private var showPokemon: Pokemon?
    @Namespace var showPokemonId
    var onShowPokemon: (Pokemon?) -> Void
    var onRemovePokemon: ((Pokemon?) -> Void)
    
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
                Spacer()
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
                                PokebalView(radius: 25)
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
                    }
                }
            }
        }
    }
}

#Preview {
    @Environment(\.container) var container
    
    return PokeBallBeltView(selectedPokemons: JsonReader.readPokemons(), onShowPokemon: { _ in }, onRemovePokemon: {_ in })
        .inject(container: container)
        .preferredColorScheme(.dark)
}
