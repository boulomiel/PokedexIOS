//
//  TabRootView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 16/02/2025.
//
import SwiftUI

public protocol CustomTabProtocol: Hashable {
    associatedtype TabContent: View
    func tab(selected: @escaping @Sendable @MainActor (Self) -> Void) -> TabContent
}

@resultBuilder
public struct TabResultBuilder<Element> {
    
    public static func buildBlock(_ components: Element...) -> [Element] {
        components.compactMap { $0 }
    }
}

public struct CustomTabView<Tab: CustomTabProtocol>: View {
    
    @TabResultBuilder<Tab> public let tabs: () -> [Tab]
    public let onSelected: (Tab) -> Void
    
    public init(@TabResultBuilder<Tab> tabs: @escaping () -> [Tab],
                onSelected: @escaping (Tab) -> Void) {
        self.tabs = tabs
        self.onSelected = onSelected
    }
    
    public var body: some View {
        HStack {
            ForEach(tabs(), id: \.self) {
                $0.tab { 
                    onSelected($0)
                }
            }
        }
        .foregroundStyle(.white)
        .background(RoundedRectangle(cornerRadius: 4).fill(.ultraThinMaterial))
        .ignoresSafeArea()
        .frame(height: 40)
    }
}
