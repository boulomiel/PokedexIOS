//
//  ListMoveCellView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 25/04/2024.
//

import Foundation
import SwiftUI
import Resources
import Tools
import DI
import Dtos

public struct ListMoveCellView: View {
    
    @State private var isSelected: Bool = false
    @State private var showEffect: Bool = false
    
    let move: Move
    let isSelectable: Bool
    @Bindable var provider: PokemonSelectionMoveListScreen.Provider
    
    var movePower: String {
        if let power = move.power, power > 0 {
            return "\(power)"
        } else {
            return ""
        }
    }
    
    public var body: some View {
        VStack {
            Label(
                title: {
                    moveInfoView
                },
                icon: {
                    moveIconView
                }
            )
        }
        .gesture(TapGesture().onEnded({ _ in
            if isSelectable {
                withAnimation {
                    showEffect.toggle()
                }
                Vibrator.change(of: .soft)
            }
        }), including: .all)
        .onAppear(perform: {
            isSelected = provider.isSelected(move: move)
        })
    }
    
    
    var moveInfoView: some View {
        VStack {
            if isSelectable, showEffect {
                Text(move.effectEntries.first(where: { $0.language.name == "en" })?.shortEffect ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .transition(.asymmetric(insertion: .offset(x: -100), removal: .offset(x: 300)))
                    .padding(.leading, 30)
                
            } else {
                HStack {
                    ShrinkText(text: move.name.capitalized, alignment: .leading, font: .body.bold())
                        .padding(.leading, 30)
                    
                    Spacer()
                    
                    HStack(spacing: 8) {
                        Text(movePower)
                            .bold()
                        Text("\(move.pp) PP")
                            .bold()
                    }
                    .frame(width: 100)
                    
                    move.Icon(25)

                }
                .transition(.opacity)
                
            }
        }
    }
    
    var moveIconView: some View {
        HStack {
            MoveDamageType(rawValue:move.damageClass.name)!
                .image(width: 45, height: 25)
                .padding(.leading, provider.selectionActive ? 40 : 12)
                .onSelection(isSelected: $isSelected, isSelectable: provider.selectionActive && isSelectable, alignment: .leading, padding: .init(top: 0, leading: 12, bottom: 0, trailing: 0))
                .onTapGesture {
                    guard provider.selectionActive else { return  }
                    let hasBeenSelected = provider.selectMove(move)
                    isSelected = hasBeenSelected
                }
        }
    }
    
    public struct Anim {
        var scale: Double
        var color: Color =  Color.gray.opacity(0.3)
    }
}

#Preview {
    @Previewable @Environment(\.diContainer) var container
    let pikachu: Pokemon = JsonReader.read(for: .pikachu)
    let preview = Preview(SDPokemon.self, SDMove.self, SDItem.self, SDTeam.self)
    let sdPikachu = SDPokemon(pokemonID: pikachu.id, data: try? JSONEncoder().encode(pikachu))
    preview.addExamples([sdPikachu])
    return NavigationStack {
        PokemonSelectionMoveListScreen(provider: .init(movesAPI: .init(), movesURL: pikachu.moves.map(\.move.url), pokemonID: sdPikachu.id, modelContext: preview.container.mainContext))
    }
    .environment(TeamRouter())
    .inject(container: container)
    .preferredColorScheme(.dark)
}
