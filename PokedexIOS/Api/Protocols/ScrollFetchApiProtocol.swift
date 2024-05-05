//
//  ScrollFetchApiProtocol.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 30/04/2024.
//

import Foundation

protocol ScrollFetchApiProtocol: FetchApiProtocol {
    func fetch(session: URLSession, offset: Int) async  -> Result<Requested, ApiPokemonError>
}
