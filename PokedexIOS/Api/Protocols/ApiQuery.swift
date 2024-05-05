//
//  ApiQuert.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation

protocol ApiQuery { 
    var urlComponents: URLComponents { get }
}

protocol ScrolledApiQuery: ApiQuery {
    var limit: Int { get }
    var offset: Int { get }
}
