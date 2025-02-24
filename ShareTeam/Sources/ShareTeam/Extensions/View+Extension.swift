//
//  View+Extension.swift
//  ShareTeam
//
//  Created by Ruben Mimoun on 24/02/2025.
//

import SwiftUI

extension View {
    
    public func onAppDidBecomeActive(_ execute: @escaping () -> Void) -> some View {
        self
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification), perform: { _ in
                execute()
            })
    }
    
}
