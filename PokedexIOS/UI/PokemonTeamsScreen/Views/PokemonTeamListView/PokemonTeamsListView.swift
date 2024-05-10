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

    let provider: Provider
    
    public var body: some View {
        List {
            if provider.teams.isEmpty {
                NavigationLink(value: AddTeamRoute()) {
                   Text("Add first team")
                }
                .foregroundStyle(.white)

            } else {
                teamList
            }
        }
    }
    
    var teamList: some View {
        ForEach(provider.teams) { team  in
            Section {
                PokemonTeamCell(team: team)
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
                let remove = provider.teams[offset]
                modelContext.delete(remove)
            }
            try? modelContext.save()
            Vibrator.notify(of: .success)
        })
    }
    
    @Observable
    class Provider {

        let grid: [GridItem] = Array(repeating: .init(.fixed(120)), count: 3)
        let modelContainer: ModelContainer
        var teams: [SDTeam]
        var subscriptions: Set<AnyCancellable>
        
        init(modelContainer: ModelContainer) {
            self.modelContainer = modelContainer
            self.teams = []
            self.subscriptions = .init()
            observer()
            Task {
                await fetch()
            }
        }
        
        private func observer() {
            NotificationCenter.default.publisher(for: .NSManagedObjectContextDidSave)
                .receive(on: DispatchQueue.main)
                .sink { notification in
                    guard let userInfo = notification.userInfo else { return }
                    Task { [weak self] in
                        await self?.fetch()
                    }
//                    if let inserts = userInfo[NSInsertedObjectsKey] as? Set<NSManagedObject> {
//                    }
//                    if let removed = userInfo[NSDeletedObjectsKey] as? Set<SDTeam> {  }
//                    
//                    if let updated = userInfo[NSUpdatedObjectsKey] as? Set<SDTeam> {
//
//                    }
                }
                .store(in: &subscriptions)
            

        }
        
        @MainActor
        private func fetch() {
            let fetchDescriptor = FetchDescriptor<SDTeam>(sortBy: [SortDescriptor(\.name, order: .forward)])
            do {
                self.teams = try modelContainer.mainContext.fetch(fetchDescriptor)
            } catch {
                print(#function, #file, error)
            }
        }
        
    }
}

#Preview {
    @Environment(\.diContainer) var container
    let preview = Preview(SDTeam.self, SDMove.self)
    preview.addExamples(SDTeam.examples)
    
    return PokemonTeamsScreen(teamRouter: .init())
        .preferredColorScheme(.dark)
        .modelContainer(preview.container)
        .inject(container: container)
}
