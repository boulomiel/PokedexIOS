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
public class PlatformManager {
    public var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    public var isIphone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    
    public var isLandscape: Bool {
        UIDevice.current.orientation.isLandscape
    }
    
    public var isPortrait: Bool {
        UIDevice.current.orientation.isPortrait
    }
}

public struct PlatformManagerKey: EnvironmentKey {
    public static var defaultValue: PlatformManager = .init()
}

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
