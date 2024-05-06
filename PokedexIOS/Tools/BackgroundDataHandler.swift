//
//  BackgroundDataHandler.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 05/05/2024.
//

import Foundation
import SwiftData

class BackgroundDataHander {
    private var context: ModelContext

    init(with container: ModelContainer) {
        context = ModelContext(container)
    }
    
    func insert(_ object: any PersistentModel) {
        context.insert(object)
    }
    
    func fetch<Model: PersistentModel>(type: Model.Type, sortDescriptors: [SortDescriptor<Model>] = [], offset: Int? = nil, fetchLimit: Int? = nil, predicate: Predicate<Model>?) -> [Model] {
        var descriptor = FetchDescriptor<Model>(predicate: predicate, sortBy: sortDescriptors)
        descriptor.fetchLimit = fetchLimit
        descriptor.fetchOffset = offset
        do {
            return try context.fetch(descriptor)
        } catch {
            print(#file, #function, error)
            return []
        }
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print(#file, #function, error)
        }
    }
}
