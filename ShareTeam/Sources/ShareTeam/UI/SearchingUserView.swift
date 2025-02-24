//
//  SearchingUserView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 09/05/2024.
//

import SwiftUI
import Resources

public struct SearchingUserView: View {
    
    private var shareSession: ShareSession
    private let displayName: String
    private let team: SharedTeam
    private let closeSheet: () -> Void
    
    @State private var shouldOpenSettings: Bool = false
    
    public init(displayName: String,
                team: SharedTeam,
                shareSession: ShareSession,
                closeSheet: @escaping () -> Void) {
        self.displayName = displayName
        self.team = team
        self.closeSheet = closeSheet
        self.shareSession = shareSession
    }
    
    public var body: some View {
        VStack {
            if shareSession.peers.isEmpty {
                searchingPlaceHolder
            } else {
                List(shareSession.peers, id:\.self) { peer in
                    Button(peer.id) {
                        shareSession.invite(peer, sharedTeam: team)
                    }
                }
                .padding(.top, 16)
                .navigationTitle("Discovered trainers")
            }
        }
        .animation(.bouncy, value: shareSession.peers)
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
                closeSheet()
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
    let mock = SharedTeamResourceAdapterMock(teamID: "", container: [])
    SearchingUserView(displayName: "Pikaman",
                      team: mock.getSharedTeam(),
                      shareSession: ShareSession()
    ) {
        
    }
    .preferredColorScheme(.dark)
}
