//
//  SearchingUserView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 09/05/2024.
//

import SwiftUI
import DI
import ShareTeam
import MultipeerConnectivity
import Tools

struct SearchingUserView: View {
    
    @Environment(\.dismiss) var dismiss
    @DIContainer private var shareSession: ShareSession
    @Environment(StartSharingView.Provider.self) private var provider
    @State private var shouldOpenSettings: Bool = false
    
    let displayName: String
    
    var body: some View {
        VStack {
            if shareSession.peers.isEmpty {
                searchingPlaceHolder
            } else {
                List(shareSession.peers, id:\.self) { peer in
                    Button(peer.id) {
                        shareSession.invite(peer, sharedTeam: provider.buildData())
                    }
                }
                .padding(.top, 16)
                .navigationTitle("Discovered trainers")
            }
        }
        .onAppear {
            shareSession.start(as: displayName) {
                shouldOpenSettings.toggle()
            }
        }
        .onAppDidBecomeActive {
            shareSession.start(as: displayName)
        }
        .alert("In order to be able to share this team, you must turn on the local network usage", isPresented: $shouldOpenSettings) {
            Button("OK", role: .cancel) {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            Button("Don't share", role: .destructive) {
                let item = DispatchWorkItem {
                    dismiss.callAsFunction()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: item)
            }
        }
    }
    
    
    private var searchingPlaceHolder: some View {
        ContentUnavailableView(label: {
            VStack {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .keyframeAnimator(initialValue: Anim(),
                                      repeating: true) { view, value in
                        view
                            .scaleEffect(value.scaleEffect)
                    } keyframes: { _ in
                        KeyframeTrack(\.scaleEffect) {
                            CubicKeyframe(0.8, duration: 0.5)
                            SpringKeyframe(1.1, duration: 0.1)
                        }
                    }

                Text("Looking for other users")
                    .foregroundStyle(.gray.opacity(0.5))
                    .bold()
            }
        })
    }
    
    struct Anim {
        var scaleEffect: Double = 1.0
    }
}

#Preview {
    @Environment(\.diContainer) var container
    let preview = Preview.allPreview
    let team = SDShareUser(name: "Jhon")
    preview.addExamples([team])
    let provider = StartSharingView.Provider(teamID: team.persistentModelID, container: preview.container, teamRouter: .init())
   return SearchingUserView(displayName: "Pikaman")
        .environment(provider)
        .modelContainer(preview.container)
        .preferredColorScheme(.dark)
}
