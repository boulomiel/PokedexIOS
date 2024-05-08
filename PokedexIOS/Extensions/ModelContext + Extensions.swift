//
//  ModelContext + Extensions.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 25/04/2024.
//

import Foundation
import SwiftData

extension ModelContext {
    func getCount<Model: PersistentModel>(_ type: Model.Type) -> Int {
        (try? fetchCount(FetchDescriptor<Model>())) ?? 0
    }
    
    func fetchUniqueSync<Model: PersistentModel>(with id: Int, limit: Int, predicate: Predicate<Model>? = nil, descriptors: [SortDescriptor<Model>] = []) -> Model? {
        var descriptor = FetchDescriptor<Model>(predicate: predicate, sortBy: descriptors)
        descriptor.fetchLimit = 1
        do {
            if let first = try fetch(descriptor).first {
                return first
            } else {
                return nil
            }
        } catch {
            print(#file, #function, error)
            return nil
        }
    }
    
    func fetchUniqueSync<Model: PersistentModel>(_ type: Model.Type, with id: PersistentIdentifier) -> Model? {
        var descriptor = FetchDescriptor<Model>(predicate: #Predicate<Model>{ model in model.persistentModelID == id })
        descriptor.fetchLimit = 1
        do {
            if let first = try fetch(descriptor).first {
                return first
            } else {
                return nil
            }
        } catch {
            print(#file, #function, error)
            return nil
        }
    }
}
