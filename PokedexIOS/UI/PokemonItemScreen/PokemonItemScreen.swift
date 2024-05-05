//
//  PokemonItemScreen.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 30/04/2024.
//

import SwiftUI

struct PokemonItemScreen: View {
    
    @DIContainer var scrollFetchItemApi: ScrollFetchItemApi
    @DIContainer var fetchItemApi: PokemonItemApi

    var body: some View {
        ItemScrolledContent(provider: .init(api: scrollFetchItemApi, fetchApi: fetchItemApi))
    }
}

#Preview {
    @Environment(\.container) var container
    return PokemonItemScreen()
        .inject(container: container)
        .preferredColorScheme(.dark)
}
