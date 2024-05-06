//
//  PokedexIOSApp.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import SwiftUI
import SwiftData
import FirebaseCore

@main
struct PokedexIOSApp: App {
    
    @Environment(\.diContainer) var container
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .inject(container: container)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .modelContainer(container.swiftDataController.container)
        }
    }
}



class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
