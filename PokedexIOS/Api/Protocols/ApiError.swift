//
//  ApiError.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation

protocol ApiError {
    static func http(description: Error) -> Self
    static func status(description: Int) -> Self
    static func decoding(description: Error) -> Self
}
