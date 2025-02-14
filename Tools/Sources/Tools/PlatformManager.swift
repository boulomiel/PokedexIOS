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
@MainActor
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
    nonisolated(unsafe) public static var defaultValue: PlatformManager = .init()
}

public extension EnvironmentValues {
    
    @MainActor
    var isIpad: Bool {
        self[PlatformManagerKey.self].isIpad
    }
    
    
    @MainActor
    var isIphone: Bool {
        self[PlatformManagerKey.self].isIphone
    }
    
    
    @MainActor
    var isLandscape: Bool {
        self[PlatformManagerKey.self].isLandscape
    }
    
    @MainActor
    var isPortrait: Bool {
        self[PlatformManagerKey.self].isPortrait
    }
}
