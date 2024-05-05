//
//  PokemonMoveDetailsScreen.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 23/04/2024.
//

import SwiftUI

struct PokemonMoveDetailsScreen: View {
    
    let move: MoveItemDataHolder
    
    var body: some View {
        VStack {
            
            moveHeader

            Text("Description")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.subheadline)
                .bold()
                .padding(.top, 40)
            
            Text("\(move.effects.first?.effect ?? "")")
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            
            
            Text("Priority: \(move.priority)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.subheadline)
                .bold()
                .padding(.top, 20)
            
            Text("Priority is a characteristic of moves, such that any move with a higher priority than another will always be performed first. When two moves have the same priority, the users' Speed statistics will determine which one is performed first in a battle.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.body)
                .padding(.top, 8)
            
            
            Text("Learnt also by")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.subheadline)
                .bold()
                .padding(.top, 40)
            
            PokemonGridListView(provider: .init(fetchApi: .init(), pokemons: move.learntBy))
        }
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    var moveHeader: some View {
        HStack {
            Image(move.type)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .padding(10)
                .background(Circle().stroke().foregroundStyle(.white))
            VStack {
                HStack {
                    Text(move.name.first(where: { $0.language == "en" })?.name ?? "")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title)
                        .bold()
                    move.damageClass.image(width: 80, height: 40)
                }
                HStack {
                    Text(move.type.capitalized)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.caption)
                        .bold()
                                        
                    Text("Power Points: \(move.pp)")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.caption)
                        .bold()
                }
            }
        }
    }
}

#Preview {
    @Environment(\.container) var container
    
    return NavigationStack {
        
        PokemonMoveDetailsScreen(move: .init(id: 10,
                                             name: [.init(name: "Amber", language: "en")],
                                             effects: [],
                                             type: "fire",
                                             damageClass: .physical,
                                             generation: "generation-i",
                                             learntBy: ["pikachu", "raichu", "gengar"],
                                             priority: 2, pp: 10))
        .inject(container: container)
        .preferredColorScheme(.dark)
    }
}
