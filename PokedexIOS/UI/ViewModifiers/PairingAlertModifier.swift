//
//  PairingAlertModifier.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 09/05/2024.
//

import Foundation
import SwiftUI
import ShareTeam
import DI
import Dtos

struct PairingAlertModifier: ViewModifier {
    
    @Environment(\.modelContext) var modelContext
    @DIContainer var shareSession: ShareSession
    @State private var inviteFrom: String = ""
    @State private var showInvitation: Bool = false
    @State private var isPaired: Bool = false
    
    func body(content: Content) -> some View {
        content
            .onReceive(shareSession.event, perform: { event in
                switch event {
                case let .isPaired(isPaired):
                    self.isPaired = isPaired
                case let .receivedData(data: data):
                    decodeData(data: data)
                case let .receivedInvite(from: invite):
                    self.inviteFrom = invite.displayName
                    self.showInvitation = true
                case .sent:
                    break
                }
            })
            .alert("\(inviteFrom.capitalized) would like to share a team with you", isPresented: $showInvitation) {
                Button("Accept") {
                    shareSession.answerInvitation(isAccepted: true)
                }
                Button("Cancel") {
                    shareSession.answerInvitation(isAccepted: false)
                }
            }
    }
    
    private func decodeData(data: Data) {
        do {
            let decoded = try JSONDecoder().decode(SharedTeam.self, from: data)

            let sdTeam = SDTeam(name: decoded.name)
            modelContext.insert(sdTeam)
            
            var sdPokemons: [SDPokemon] = []
            decoded.pokemons.forEach { sharedPokemon in
                let ability = SDAbility(abilityID: sharedPokemon.ability?.id ?? 0, data: try? JSONEncoder().encode(sharedPokemon.ability))
                modelContext.insert(ability)
                let nature = SDNature(natureID: sharedPokemon.nature?.id ?? 0, data: try? JSONEncoder().encode(sharedPokemon.nature))
                modelContext.insert(nature)
                let item = SDItem(itemID: sharedPokemon.item?.id ?? 0, data: try? JSONEncoder().encode(sharedPokemon.item))
                modelContext.insert(item)
                var moves: [SDMove] = []
                sharedPokemon.move?.forEach({ move in
                    let sdMove = SDMove(moveID: move.id, data: try? JSONEncoder().encode(move))
                    moves.append(sdMove)
                    modelContext.insert(sdMove)
                })
                
                let pokemon = SDPokemon(pokemonID: sharedPokemon.pokemon?.order ?? 0, data: try? JSONEncoder().encode(sharedPokemon.pokemon))
                modelContext.insert(pokemon)
                pokemon.nature = nature
                pokemon.ability = ability
                pokemon.moves = moves
                sdPokemons.append(pokemon)
            }
            sdTeam.pokemons = sdPokemons
            
            try modelContext.save()
            
        } catch {
            print(#file, #function, error)
        }
    }
}


extension View {
    
    func pairingAlert() -> some View {
        modifier(PairingAlertModifier())
    }
    
}
