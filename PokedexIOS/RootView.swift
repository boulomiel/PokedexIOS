//
//  ContentView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import SwiftUI
import CoreData
import Tools
import DI
import ShareTeam
import SwiftData

public struct RootView: View {
    @Environment(\.modelContext) private var modelContext
    @DIContainer var appLauncher: AppLaunchWorker
    @DIContainer var fetchApi: FetchPokemonApi
    @DIContainer var speciesApi: PokemonSpeciesApi
    @DIContainer var shareSession: ShareSession
    @State var breath: Bool = false
    @State var tabRoot: TabRoot? = .pokedex
    
    public var body: some View {
        if appLauncher.shouldWait {
            setupView
        } else {
            screen
                .preferredColorScheme(.dark)
                .padding(.bottom, 26)
                .overlay(alignment: .bottom) {
                    VStack{
                        Spacer()
                        HStack {
                            Button(action: {
                                withAnimation {
                                    tabRoot = .pokedex
                                }
                            }, label: {
                                Text("Pokedex")
                                    .bold()
                                    .font(.caption)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                    .foregroundStyle(tabRoot == .pokedex ? .white : .gray.opacity(0.5))
                            })
                            
                            Button(action: {
                                withAnimation {
                                    tabRoot = .teams
                                }
                            }, label: {
                                Text("Teams")
                                    .bold()
                                    .font(.caption)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                    .foregroundStyle(tabRoot == .teams ? .white : .gray.opacity(0.5))
                            })
                        }
                    }
                    .foregroundStyle(.white)
                    .background(RoundedRectangle(cornerRadius: 4).fill(.ultraThinMaterial))
                    .ignoresSafeArea()
                    .frame(height: 25)
                }
                .onAppear {
                    var descriptor = FetchDescriptor<SDShareUser>()
                    descriptor.fetchLimit = 1
                    let user = try? modelContext.fetch(descriptor)
                    let displayName = user?.first?.name ?? UIDevice.current.name
                    shareSession.start(as: displayName)
                }
                .pairingAlert()
        }
    }
    
    @ViewBuilder
    var screen: some View {
        switch  tabRoot {
        case .pokedex, .none:
            pokedexContent
                .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .identity))
        case .teams:
            teamContent
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .identity))
        }
    }
    
    var setupView: some View {
        ContentUnavailableView(label: {
            PokebalView(radius: 100)
                .keyframeAnimator(initialValue: Anim(scaleEffect: 1.0), repeating: true, content: { view, value in
                    view
                        .scaleEffect(value.scaleEffect)
                }) { _ in
                    KeyframeTrack(\.scaleEffect) {
                        CubicKeyframe(0.8, duration: 0.5)
                        SpringKeyframe(1.1, duration: 0.2)
                    }
                }
        }, description: {
            VStack {
                Text("Loading Pr.Oak's database")
                    .bold()
                    .foregroundStyle(Color.white.opacity(0.3))
                ProgressView()
            }
        })
        .background(Color.black)
        .ignoresSafeArea()
    }
    
    var pokedexContent: some View {
        PokedexScreen()
    }
    
    var teamContent: some View {
        PokemonTeamsScreen(teamRouter: .init())
    }
    
    enum TabRoot {
        case pokedex, teams
    }
    
    public struct Anim {
        var scaleEffect: CGFloat
    }

}
#Preview {
    @Previewable @Environment(\.diContainer) var container
    let preview = Preview.allPreview
    
    return RootView()
        .inject(container: container)
        .modelContainer(preview.container)
        .environment(TeamRouter())
}
