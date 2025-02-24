//
//  SharedTeamResource.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/02/2025.
//

import Resources
import Dtos

@MainActor
public protocol SharedTeamResource {
    associatedtype ID
    associatedtype Container
    
    var teamID: ID { get }
    var container: Container { get }
    
    func getSharedTeam() -> SharedTeam
    func saveUser(username: String, isNew: Bool)
}


class SharedTeamResourceAdapterMock: SharedTeamResource {
        
    let teamID: String
    var container: [String]
    
    init(teamID: String, container: [String]) {
        self.teamID = teamID
        self.container = container
    }

    func getSharedTeam() -> SharedTeam {
        
        let moves: [Move] = JsonReader.JsonFiles.pokemonMoves.map {
            JsonReader.read(for: $0)
        }
        
        let pokemons: [Pokemon] = JsonReader.JsonFiles.pokemonFiles.map {
            JsonReader.read(for: $0)
        }
        
        let shared: [SharedPokemon] = pokemons.map { p in
            SharedPokemon(pokemon: p,
                          move: moves,
                          item: nil,
                          nature: nil,
                          ability: nil)
        }
            
        return SharedTeam(name: "Dream",
                   pokemons: shared)
    }
    
    func saveUser(username: String, isNew: Bool) {
        if isNew {
            container.append(username)
        } else {
            container[0] = username
        }
    }
    
    private func fetch() -> String? {
        container.first
    }
}
