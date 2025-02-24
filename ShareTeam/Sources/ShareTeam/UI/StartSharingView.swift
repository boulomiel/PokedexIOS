//
//  StartSharingView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 09/05/2024.
//

import SwiftUI
import SwiftData
import Tools

public struct StartSharingView: View {
    
    enum ViewState {
        case foundUser(username: String)
        case notFoundUser
        case searching
    }
    
    private let shareSession: ShareSession

    @State private var username: String = ""
    @State private var viewState: ViewState = .notFoundUser
    private let provider: Provider
    
    public init(provider: Provider, shareSession: ShareSession, username: String?) {
        self.shareSession = shareSession
        self.provider = provider
        if let username {
            viewState = .foundUser(username: username)
            self.username = username
        } else {
            viewState = .notFoundUser
        }
    }
    
    public var body: some View {
        NavigationStack {
            switch viewState {
            case .foundUser(let username):
                UserFoundUI(user: username)
            case .notFoundUser:
                NoUserUI()
                    .animation(.bouncy, value: username)
            case .searching:
                SearchingUserView(displayName: username, team: provider.team, shareSession: shareSession){
                    provider.teamRouter.closeSharingSheet()
                }
                .transition(.move(edge: .bottom))
                .onReceive(shareSession.event, perform: { event in
                    switch event {
                    case .sent:
                         Vibrator.notify(of: .success)
                        provider.teamRouter.closeSharingSheet()
                    default: break
                    }
                })
            }
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
    private func UserFoundUI(user: String) -> some View {
        VStack {
            Text("Would you like to update your device name ?")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
                .foregroundStyle(.white.opacity(0.5))
            
            Spacer()
            
            textfieldView
                .padding(.horizontal, 20)
                .onAppear {
                    self.username = user
                }
            
            HStack {
                Spacer()
                SaveButton("Update and continue", isNew: false)
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
        }
        .navigationTitle("Hey \(user)")
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
            provider.saveUser(username: username, isNew: isNew)
            withAnimation {
                viewState = .searching
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
    public final class Provider {
        
        let resource: any SharedTeamResource
        let teamRouter: ShareTeamRouter
        let team: SharedTeam
        
        public init(resource: any SharedTeamResource, teamRouter: ShareTeamRouter) {
            self.teamRouter = teamRouter
            self.resource = resource
            team = resource.getSharedTeam()
        }
        
        func saveUser(username: String, isNew: Bool) {
            resource.saveUser(username: username, isNew: isNew)
        }
    }
}

#Preview {
    
    let provider = StartSharingView.Provider(resource: SharedTeamResourceAdapterMock(teamID: "team.persistentModelID", container: []),
                                             teamRouter: ShareTeamRouterAdapterMock())
    NavigationStack {
        StartSharingView(provider: provider, shareSession: ShareSession(), username: "Pikaman")
    }
    .preferredColorScheme(.dark)
}
