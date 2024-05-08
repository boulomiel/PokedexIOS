//
//  AppLaunchWorker.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 05/05/2024.
//

import Foundation
import SwiftData
// firstStep = https://pokeapi.co/api/v2/pokemon/
//secondStep = https://pokeapi.co/api/v2/pokemon/?offset=0&limit=1302

@Observable
class AppLaunchWorker {
    
    var hasBeenLaunched: Bool {
        get {
            UserDefaults.standard.bool(forKey: "AppLaunchWorker_firstLaunch")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "AppLaunchWorker_firstLaunch")
        }
    }
    
    var lastLaunched: Date {
        get {
            let timeInterval = UserDefaults.standard.double(forKey: "AppLaunchWorker_lastDate")
            return Date(timeIntervalSince1970: TimeInterval(timeInterval))
        }
        set {
            UserDefaults.standard.set(newValue.timeIntervalSince1970, forKey: "AppLaunchWorker_lastDate")
        }
    }
    
    var shouldWait: Bool {
        !isFinished
    }
    
    var isFinished: Bool
    let namedLauncherWorkers: [any NameLauncherProtocol]
    let container: ModelContainer
    
    
    init(namedLauncherWorkers: [any NameLauncherProtocol], container: ModelContainer) {
        self.namedLauncherWorkers = namedLauncherWorkers
        self.container = container
        self.isFinished = false
        setupData()
    }
    
    private func shouldRefresh() -> Bool {
        guard let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: lastLaunched) else {
            return false
        }
        return nextDay <= Date.now
    }
    
    private func setupData() {
        guard shouldRefresh() else {
            isFinished = true
            return
        }
        Task {
            await withTaskGroup(of: Void.self) { group in
                self.namedLauncherWorkers.forEach { worker in
                    group.addTask {
                        await worker.setup(container: self.container)
                    }
                }
            }
            hasBeenLaunched = true
            lastLaunched = .now
            await MainActor.run {
                isFinished = true
            }
        }
    }
}

