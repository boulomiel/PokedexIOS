//
//  File.swift
//  
//
//  Created by Ruben Mimoun on 09/05/2024.
//

import Foundation
import SwiftData

@Model
public class SDShareUser {

    @Attribute(.unique)
    public var name: String

    public init(name: String) {
        self.name = name
    }
}


