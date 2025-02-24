//
//  SharedTeamResourceAdapter.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/02/2025.
//
import AppPersistence
import SwiftData
import ShareTeam

class SharedTeamResourceAdapter: SharedTeamResource {
    
    let teamID: PersistentIdentifier
    let container: ModelContainer
    
    init(teamID: PersistentIdentifier, container: ModelContainer) {
        self.teamID = teamID
        self.container = container
    }
    
    func getSharedTeam() -> ShareTeam.SharedTeam {
        let team = container.mainContext.fetchUniqueSync(SDTeam.self)
        let name = team?.name ?? ""
        let sharedPokemon = team?.pokemons?.map({ sdPokemon in
            SharedPokemon(pokemon: sdPokemon.decoded,
                          move: sdPokemon.moves?.compactMap(\.decoded),
                          item: sdPokemon.item?.decoded,
                          nature: sdPokemon.nature?.decoded,
                          ability: sdPokemon.ability?.decoded)
        }) ?? []
        return SharedTeam(name: name, pokemons: sharedPokemon)
    }
    
    func saveUser(username: String, isNew: Bool) {
        if isNew {
            let user = SDShareUser(name: username)
            container.mainContext.insert(user)
        } else {
            let user =  container.mainContext.fetchUniqueSync(SDShareUser.self)
            user?.name = username
        }
        try? container.mainContext.save()
    }
    
    private func fetch() -> SDTeam? {
        container.mainContext.fetchUniqueSync(SDTeam.self, with: teamID)
    }
}
