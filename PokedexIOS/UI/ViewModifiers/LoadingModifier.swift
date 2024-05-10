//
//  LoadingModifier.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 01/05/2024.
//

import SwiftUI

public struct LoadingModifier: ViewModifier {
    
    let showProgress: Bool
    @Namespace private var loading
    static var loadingID: String = "loading"

    public func body(content: Content) -> some View {
        content
            .overlay {
                if showProgress {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(1.5)
                        .matchedGeometryEffect(id: Self.loadingID, in: loading)
                }
            }
    }
}

extension View {
    func loadable(isLoading: Bool) -> some View {
        modifier(LoadingModifier(showProgress: isLoading))
    }
}

#Preview {
    Text("Hello")
}
