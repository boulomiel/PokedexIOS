//
//  PokemonAbilityView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 19/04/2024.
//

import SwiftUI
let testpokemonability = PokemonAbilityDetails(
    name: "overgrow",
    isHidden: false
)

let testpokemonability2 = PokemonAbilityDetails(
    name: "stench",
    isHidden: false
)

let testpokemonability3 = PokemonAbilityDetails(
    name: "2",
    isHidden: false
)

struct ShowOtherItem: Identifiable {
    let id: UUID = .init()
    let title: String
    let pokemons: [String]
}

struct PokemonAbilityView: View {
    
    let provider: Provider
    @State private var isExpanded: Bool = false
    @State private var showOtherItem: ShowOtherItem?
    
    var body: some View {
        VStack(spacing: 8) {
            disclosedContent
        }
        .onChange(of: isExpanded, { _, _ in
            Vibrator.selection()
        })
        .sheet(item: $showOtherItem) { item in
            PokemonGridScreen(provider: .init(pokemons: item.pokemons, title: item.title))
        }
    }

    @ViewBuilder
    var disclosedContent: some View {
        if let abilityModel = provider.pokemonAbilityListModel {
            DisclosureGroup(
                isExpanded: $isExpanded,
                content: {
                    disclosureContentView(abilityModel: abilityModel)
                },
                label: {
                    disclosureLabel
                })
        }
    }
    
    private func disclosureContentView(abilityModel: PokemonAbilityListModel) -> some View {
        VStack {
            if let effectEntry = abilityModel.effectEntry {
                textEntrySection(
                    sectionName: "Battle Effect",
                    content: effectEntry
                )
            }
            if let effectChange = abilityModel.effectChange {
                textEntrySection(
                    sectionName: "Effect",
                    content: effectChange
                )
            }
            if let flavorText = abilityModel.flavorText {
                textEntrySection(
                    sectionName: "In game",
                    content: flavorText
                )
            }
            
            if !abilityModel.pokemonsWithEffect.isEmpty {
                Button(action: {
                    Vibrator.change(of: .light)
                    showOtherItem = .init(title: provider.ability.name.capitalized.appending(" ").appending("users"), pokemons: abilityModel.pokemonsWithEffect)
                }, label: {
                    Label("Find pokemon sharing this ability", systemImage: "magnifyingglass")
                        .frame(maxWidth: .infinity, alignment: .leading)
                })
                .padding(.top, 8)
                .buttonStyle(.plain)
                .foregroundStyle(.blue)
            }
        }
    }
    
    private var disclosureLabel: some View {
        VStack {
            HStack {
                Text(provider.ability.name.capitalized)
                    .font(.title2)
                    .bold(isExpanded)
                Spacer()
                Text("Hidden")
                    .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                    .containerShape(shape)
                    .background(shape.fill(.white.opacity(0.3)))
                    .overlay(shape.stroke().foregroundStyle(.white))
                    .opacity(provider.ability.isHidden ? 1 : 0.3)
            }
        }
    }
    
    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 20)
    }
    
    func textEntrySection(sectionName: String, content: String) -> some View {
        VStack(alignment: .leading) {
            Text(sectionName)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(content)
                .font(.body)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)

        }
        .padding(.top, 8)
    }
    
    @Observable
    class Provider: Identifiable {
        
        let id: UUID = .init()
        let ability: PokemonAbilityDetails
        let api: PokemonAbilityApi
        var pokemonAbilityListModel: PokemonAbilityListModel?
        
        init(ability: PokemonAbilityDetails, api: PokemonAbilityApi) {
            self.ability = ability
            self.api = api
            Task {
                await fetch(abilityName: ability.name)
            }
        }
        
        private func fetch(abilityName: String) async {
            let result = await api.fetch(query: .init(number: abilityName))
            switch result {
            case .success(let success):
                await MainActor.run {
                    makeModel(from: success)
                }
            case .failure(let failure):
                print(#file, #function, failure)
            }
        }
        
        private func makeModel(from success: Ability) {
            let effectChange = success.effectChanges
                .flatMap { $0.effectEntries }
                .first(where: { $0.language.name == "en" })?.effect
            
            let effectEntry = success.effectEntries
                .first(where: { $0.language.name == "en" })?.effect
            
            let flavorText = success.flavorTextEntries
                .first(where: { $0.language.name == "en"})?.flavorText
            
            let pokemons = success.pokemon.map(\.pokemon.name)
            
            pokemonAbilityListModel = .init(
                effectChange: effectChange,
                effectEntry: effectEntry,
                flavorText: flavorText,
                pokemonsWithEffect: pokemons
            )
        }
    }
}

struct PokemonAbilityListModel: Hashable, Identifiable {
    let id: UUID = .init()
    let effectChange: String?
    let effectEntry: String?
    let flavorText: String?
    let pokemonsWithEffect: [String]
}

fileprivate struct HiddenAbilityTextSyle: LabelStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.title
            .border(Color.red)
    }
}

#Preview {
    PokemonAbilityView(provider: .init(ability: testpokemonability, api: .init()))
    .preferredColorScheme(.dark)
}


