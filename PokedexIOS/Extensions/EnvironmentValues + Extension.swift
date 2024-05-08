//
//  EnvironmentValues + Extension.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 07/05/2024.
//

import Foundation
import SwiftUI

public extension EnvironmentValues {
    var isIpad: Bool {
        self[PlatformManagerKey.self].isIpad
    }
    
    var isIphone: Bool {
        self[PlatformManagerKey.self].isIphone
    }
    
    var isLandscape: Bool {
        self[PlatformManagerKey.self].isLandscape
    }
    
    var isPortrait: Bool {
        self[PlatformManagerKey.self].isPortrait
    }
}
