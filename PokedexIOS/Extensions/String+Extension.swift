//
//  String+Extension.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 22/04/2024.
//

import Foundation

extension String {
    
    var trimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}
