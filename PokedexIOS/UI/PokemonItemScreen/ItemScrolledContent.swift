//
//  ItemScrollList.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 30/04/2024.
//

import SwiftUI
import Combine

struct ItemScrolledContent: View {
    typealias Provider = PaginatedList<Self, ScrollFetchItemApi, PokemonItemApi>.Provider
    @Bindable var provider: Provider
    
    var body: some View {
        content
    }
    
    var content: some View {
        List {
            listContent
                .listRowBackground(EmptyView())
        }
    }
    
    var forEach: some View {
        ForEach(Array(provider.config.list), id:\.offset) { offset, element in
            ItemCell(provider: .init(api: provider.fetchApi, scrolledFetchedItem: element))
                .onAppear {
                    provider.update(from: offset)
                }
                .id(element.name)
        }
    }
    
    @ViewBuilder
    var listContent: some View {
        if let fetched = provider.searched {
            ItemCell(provider: .init(api: provider.fetchApi, scrolledFetchedItem: .init(name: fetched.name, url: .documentsDirectory)))
                .id(fetched.name)
        } else {
            forEach
        }
    }
}

#Preview {
    @Environment(\.container) var container
    
    return NavigationStack {
        PaginatedList(provider: .init(api: ScrollFetchItemApi(), fetchApi: PokemonItemApi())) { provider in
           ItemScrolledContent(provider: provider)
       }
    }
    .inject(container: container)
    .preferredColorScheme(.dark)
}
