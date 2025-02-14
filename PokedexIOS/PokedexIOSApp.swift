//
//  PokedexIOSApp.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import SwiftUI
import SwiftData
import FirebaseCore
import DI

@main
public struct PokedexIOSApp: App {
    
    @Environment(\.diContainer) var container
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    public init() {}
    
    public var body: some Scene {
        WindowGroup {
            RootView()
                .inject(container: container)
                .modelContainer(container.modelContainer)
        }
    }
}



class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
#if !targetEnvironment(simulator) && !DEBUG
        FirebaseApp.configure()
#endif
        return true
    }
}
