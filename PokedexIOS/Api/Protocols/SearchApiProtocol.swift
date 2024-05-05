//
//  SearchApiProtocol.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 30/04/2024.
//

import Foundation

protocol SearchApiProtocol: FetchApiProtocol {
    func fetch(id: String) async  -> Result<Requested, ApiPokemonError>
}
