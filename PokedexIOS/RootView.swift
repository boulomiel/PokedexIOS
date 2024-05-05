//
//  ContentView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import SwiftUI
import CoreData

struct RootView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @DIContainer var fetchApi: FetchPokemonApi
    @DIContainer var speciesApi: PokemonSpeciesApi
    @State var tabRoot: TabRoot? = .pokedex
    
    var body: some View {
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
    
    var pokedexContent: some View {
        PokedexScreen()
    }
    
    var teamContent: some View {
        PokemonTeamsScreen(teamRouter: .init())
    }
    
    enum TabRoot {
        case pokedex, teams
    }

}
#Preview {
    let preview = Preview.allPreview
    @Environment(\.container) var container
    
    return RootView()
        .inject(container: container)
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .modelContainer(preview.container)
        .environment(TeamRouter())
}
