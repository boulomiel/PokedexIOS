//
//  PokemonBeltView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import SwiftUI
import Resources

public struct PokeBallBeltView<Content: View>: View {
    
    let selectedPokemons: [Pokemon]
    var onShowPokemon: (Pokemon?) -> Void
    var onRemovePokemon: ((Pokemon?) -> Void)
    @ViewBuilder var buildTeamButton: Content
    
    @Environment(\.isIphone) private var isIphone
    
    private var pokeballRadius: CGFloat {
        canShowBuildButton ? 20 : 25
    }
    
    private var canShowBuildButton: Bool {
        isIphone && selectedPokemons.count == 6
    }
    
    @State private var showPokemon: Pokemon?
    @Namespace private var showPokemonId

    public var body: some View {
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
                                PokebalView(radius: pokeballRadius)
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
                        
                        if canShowBuildButton  {
                            buildTeamButton
                        }
                    }
                }
            }
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
