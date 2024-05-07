//
//  ToolBox.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 07/05/2024.
//

import Foundation
import UIKit
import SwiftUI

@Observable
class PlatformManager {
    var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    var isIphone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    
    var isLandscape: Bool {
        UIDevice.current.orientation.isLandscape
    }
    
    var isPortrait: Bool {
        UIDevice.current.orientation.isPortrait
    }
}

struct PlatformManagerKey: EnvironmentKey {
    static var defaultValue: PlatformManager = .init()
}

extension EnvironmentValues {
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
