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
    
    @Environment(\.diContainer) var container
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .inject(container: container)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .modelContainer(container.swiftDataController.container)
        }
    }
    
}
