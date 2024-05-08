//
//  NameLauncherProtocol.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 05/05/2024.
//

import Foundation
import SwiftData

public protocol NameLauncherProtocol {
    associatedtype T: Decodable
    associatedtype Model: PersistentModel
    func getCount() async -> Int
    func getAll() async -> [NamedAPIResource]
    func get(for name: String) async -> T?
    func buildModel(for name: String) async -> Model?
    func setup(container: ModelContainer) async
}
