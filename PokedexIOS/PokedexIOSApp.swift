//
//  PokedexIOSApp.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import SwiftUI
import SwiftData

@main
struct PokedexIOSApp: App {
    
    @Environment(\.container) var container
    let persistenceController = PersistenceController.shared
    let swiftDataController: SwiftDataController
    
    init() {
        swiftDataController = .init(models: SDTeam.self, SDPokemon.self, SDMove.self, SDItem.self, SDAbility.self, isTesting: false)
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .inject(container: container)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .modelContainer(swiftDataController.container)
        }
    }
}
