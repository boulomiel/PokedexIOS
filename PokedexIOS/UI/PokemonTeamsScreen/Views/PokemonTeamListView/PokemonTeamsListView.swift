//
//  PokemonTeamsListView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import SwiftUI
import SwiftData
import Tools
import DI
import Dtos
import Combine
import CoreData

public struct PokemonTeamsListView: View {
    
    @Environment(TeamRouter.self)
    var teamRouter
    
    @Environment(\.modelContext)
    var modelContext

    @Query(FetchDescriptor<SDTeam>(sortBy: [SortDescriptor(\.name, order: .forward)]))
    var teams: [SDTeam]
    
    public var body: some View {
        List {
            if teams.isEmpty {
                NavigationLink(value: AddTeamRoute()) {
                   Text("Add first team")
                }
                .foregroundStyle(.white)

            }
              teamList
        }
    }
    
    var teamList: some View {
        ForEach(teams) { team  in
            Section {
                PokemonTeamCell(provider: .init(team: team))
            } header: {
                HStack{
                    Text(team.name.capitalized)
                        .bold()
                    Spacer()
                    Button(action: {
                        teamRouter.navigate(to: AddTeamRoute(selectedPokemons: team.pokemons?.compactMap(\.decoded) ?? [] , teamID: team.persistentModelID))
                    }, label: {
                        Image(systemName: "square.and.pencil")
                            .foregroundStyle(.blue)
                    })
                }
            }
        }
        .onDelete(perform: { indexSet in
            for offset in indexSet {
                let remove = teams[offset]
                modelContext.delete(remove)
            }
            try? modelContext.save()
            Vibrator.notify(of: .success)
        })
    }
}

#Preview {
    @Previewable @Environment(\.diContainer) var container
    let preview = Preview(SDTeam.self, SDMove.self)
    preview.addExamples(SDTeam.examples)
    
    return PokemonTeamsScreen(teamRouter: .init())
        .preferredColorScheme(.dark)
        .modelContainer(preview.container)
        .inject(container: container)
}
