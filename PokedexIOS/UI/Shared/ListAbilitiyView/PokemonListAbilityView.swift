//
//  PokemonListAbilityView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import SwiftUI

struct PokemonListAbilityView: View {
    
    @Bindable var provider: Provider
    
    var body: some View {
        ForEach(provider.providers, id: \.id) { provider in
            PokemonAbilityView(provider: provider)
        }
    }
    
    @Observable
    class Provider {
        typealias CellProvider = PokemonAbilityView.Provider
        let abilityApi: PokemonAbilityApi
        let abilities: [PokemonAbilityDetails]
        var providers: [CellProvider]
        
        init(abilityApi: PokemonAbilityApi, abilities: [PokemonAbilityDetails]) {
            self.abilityApi = abilityApi
            self.abilities = abilities
            providers = abilities.map { ability in
                CellProvider(ability: ability, api: abilityApi)
            }
        }
    }
}

#Preview {
    @Environment(\.diContainer) var container
    let abilities: [PokemonAbilityDetails] = [
        testpokemonability,
        testpokemonability2,
        testpokemonability3
    ]
    
    return List {
        Section("Abilities") {
            PokemonListAbilityView(provider: .init(abilityApi: .init(), abilities: abilities)) 
        }
    }
    .inject(container: container)
    .preferredColorScheme(
        .dark
    )
}
