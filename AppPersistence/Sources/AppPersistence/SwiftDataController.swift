//
//  SwiftDataController.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import Foundation
import SwiftData

public class SwiftDataController {
    
    public let container: ModelContainer
    
    public init(models: any PersistentModel.Type ..., isTesting: Bool) {
        let schema = Schema(models)
        let configuration = ModelConfiguration(isStoredInMemoryOnly: isTesting)
        do {
             container = try ModelContainer(for: schema, configurations: configuration)
        } catch {
            fatalError("SwiftDataController - \(error)")
        }
    }
}
