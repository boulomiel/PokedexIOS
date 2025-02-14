//
//  StartSharingView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 09/05/2024.
//

import SwiftUI
import SwiftData
import DI
import Tools
import ShareTeam

public struct StartSharingView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Environment(TeamRouter.self)
    private var teamRouter
    @DIContainer var sharingSession: ShareSession
    @Query var shareUser: [SDShareUser]
    @State private var username: String = ""
    @State private var saved: Bool = false
    
    private let provider: Provider
    
    init(provider: Provider) {
        self.provider = provider
    }
        
    public var body: some View {
        NavigationStack {
            if !saved {
                content()
            } else {
                SearchingUserView(displayName: username)
                    .environment(provider)
                    .transition(.move(edge: .bottom))
                    .onReceive(sharingSession.event, perform: { event in
                        switch event {
                        case .sent:
                            Vibrator.notify(of: .success)
                            teamRouter.closeSharingSheet()
                        default: break
                        }
                    })
            }
        }
    }
    
    @ViewBuilder
    private func content() -> some View {
        if let first = shareUser.first {
            UserFoundUI(user: first)
        } else {
            NoUserUI()
                .animation(.bouncy, value: username)
        }
    }
    
    @ViewBuilder
    private func NoUserUI() -> some View {
        Form {
            Section("Username", isExpanded: .constant(true)) {
                VStack {
                    textfieldView
                }
            }
            .listRowBackground(Color.clear)
        }
        .navigationTitle("Set a display name")
        .toolbar {
            if username.count > 3 {
                ToolbarItem(placement: .bottomBar) {
                    SaveButton("Save", isNew: true)
                        .transition(.slide)
                }
            }
        }
    }
    
    @ViewBuilder
    private func UserFoundUI(user: SDShareUser) -> some View {
        VStack {
            Text("Would you like to update your device name ?")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
                .foregroundStyle(.white.opacity(0.5))
            
            Spacer()
            
            textfieldView
                .padding(.horizontal, 20)
                .onAppear {
                    self.username = user.name
                }
            
            HStack {
                Spacer()
                SaveButton("Update and continue", isNew: false)
            }
            .padding(.horizontal, 20)

            Spacer()

        }
        .navigationTitle("Hey \(user.name)")
    }
    
    private var textfieldView: some View {
        TextField("Username", text: $username)
            .padding(4)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .foregroundStyle(.black)
    }
    
    private func SaveButton(_ title: String, isNew: Bool) -> some View {
        Button(title) {
            if isNew {
                let user = SDShareUser(name: username)
                modelContext.insert(user)
            } else {
                shareUser.first?.name = username
            }
            try? modelContext.save()
            withAnimation {
                saved = true
            }
        }
        .frame(height: 40)
        .font(.body.bold())
        .foregroundStyle(.white)
        .padding(.horizontal, 20)
        .background(
            Capsule()
                .fill(Color.blue)
        )
        .transition(.slide)
    }
    
    @Observable @MainActor
    final class Provider {
        
        let teamID: PersistentIdentifier
        let container: ModelContainer
        let teamRouter: TeamRouter
        var team: SDTeam?
        
        init(teamID: PersistentIdentifier, container: ModelContainer, teamRouter: TeamRouter) {
            self.teamID = teamID
            self.container = container
            self.teamRouter = teamRouter
            Task {
                await fetchTeam()
            }
        }
        
        @MainActor
        func fetchTeam() async {
            guard let team = container.mainContext.fetchUniqueSync(SDTeam.self, with: teamID) else {
                teamRouter.back()
                return
            }
            self.team = team
        }
        
        func buildData() -> SharedTeam {
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
    }
}

#Preview {
    @Previewable @Environment(\.diContainer) var container
    let preview = Preview.allPreview
    let team = SDShareUser(name: "Jhon")
    preview.addExamples([team])
    let provider = StartSharingView.Provider(teamID: team.persistentModelID, container: preview.container, teamRouter: .init())
    return NavigationStack {
        StartSharingView(provider: provider)
            .environment(provider)
    }
    .preferredColorScheme(.dark)
    .modelContainer(preview.container)
    .inject(container: container)
}
