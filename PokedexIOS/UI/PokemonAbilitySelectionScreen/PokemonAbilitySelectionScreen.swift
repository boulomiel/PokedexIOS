//
//  PokemonAbilitySelectionView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 28/04/2024.
//

import SwiftUI
import SwiftData

public struct PokemonAbilitySelectionScreen: View {
    
    @Environment(\.isIphone) var isIphone
    @Environment(\.isLandscape) var isLandscape
    @Environment(\.dismiss) var dismiss
    @State var provider: Provider
    
    public var body: some View {
        VStack {
            Picker(selection: $provider.selected) {
                ForEach(provider.pokemonAbilities, id: \.id) { ability in
                    Text(ability.name.capitalized).tag(ability)
                }
            } label: {
                Text("Select")
            }
            .pickerStyle(.palette)
            
            ScrollView {
                Text("Battle Effect")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                
                Text(provider.selected.effectEntry ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 4)
                
                Text("In Game")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                
                Text(provider.selected.flavorText ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 4)
            }
            .padding(.horizontal)
            
            Button {
                provider.saveAbility()
                dismiss.callAsFunction()
            } label: {
                Label("Set ability: \(provider.selected.name.capitalized)", systemImage: "checkmark")
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.2)))
                    .frame(height: 60)
            }
            .alignToRight(isIphone && isLandscape)
        }
        .onChange(of: provider.selected) { _, _ in
            Vibrator.selection()
        }
    }
    
    @Observable
   public class Provider {
        
        let pokemonID: PersistentIdentifier
        let abilities: [PokemonAbility]
        let api: PokemonAbilityApi
        var selected: PokemonAbilitySelectionModel
        let modelContext: ModelContext
        
        var pokemonAbilities: [PokemonAbilitySelectionModel]

        
        init(pokemonID: PersistentIdentifier,
             api: PokemonAbilityApi,
             abilities: [PokemonAbility],
             selected: PokemonAbilitySelectionModel?,
             modelContext: ModelContext) {
            self.pokemonID = pokemonID
            self.api = api
            self.abilities = abilities
            self.pokemonAbilities = []
            self.modelContext = modelContext
            if let selected {
                self.selected = selected
            } else {
                self.selected = .init(abilityID: -1, name: "Non", isHidden: false, effectChange: nil, effectEntry: nil, flavorText: nil)
            }
            Task {
                await fetch(abilities: abilities)
            }
        }
        
        private func fetch(abilities: [PokemonAbility]) async {
           let abilities = await withTaskGroup(of: Ability?.self) { group in
                abilities.forEach { ability in
                    group.addTask { [weak self] in
                        await self?.fetch(abilityName: ability.ability.name)
                    }
                }
               return await group.reduce(into: [Ability]()) { partialResult, ability in
                   if let ability {
                       partialResult.append(ability)
                   }
               }
            }
            
            let mapped = abilities
                .map(makeModel(from:))
                .sorted(using: SortDescriptor(\.name, order: .forward))
            await MainActor.run {
                self.pokemonAbilities = mapped
                if let first = pokemonAbilities.first {
                    self.selected = first
                }
            }
        }
        
        private func fetch(abilityName: String) async -> Ability? {
            let result = await api.fetch(query: .init(number: abilityName))
            switch result {
            case .success(let success):
                return success
            case .failure(let failure):
                print(#file, #function, failure)
                return nil
            }
        }
        
        private func makeModel(from success: Ability) -> PokemonAbilitySelectionModel {
            let effectChange = success.effectChanges
                .flatMap { $0.effectEntries }
                .first(where: { $0.language.name == "en" })?.effect
            
            let effectEntry = success.effectEntries
                .first(where: { $0.language.name == "en" })?.effect
            
            let flavorText = success.flavorTextEntries
                .first(where: { $0.language.name == "en"})?.flavorText
                                        
            return .init(
                abilityID: success.id,
                name: success.name,
                isHidden: false,
                effectChange: effectChange,
                effectEntry: effectEntry,
                flavorText: flavorText,
                abilityData: try? JSONEncoder().encode(success)
            )
        }
        
        func saveAbility() {
            let pokemon = modelContext.fetchUniqueSync(SDPokemon.self, with: pokemonID)
            let ability = SDAbility(abilityID: selected.abilityID, data: selected.abilityData)
            modelContext.insert(ability)
            pokemon?.ability = ability
            try? modelContext.save()
            Vibrator.notify(of: .success)
        }
    }
}

fileprivate extension View {
    
    @ViewBuilder
    func alignToRight(_ condition: Bool) -> some View {
        if condition {
            HStack {
                Spacer()
                self
            }
        } else {
            self
        }
    }
}

#Preview {
    @Environment(\.diContainer) var container
    let preview =  Preview.allPreview
    let dragonite: Pokemon = JsonReader.read(for: .pikachu)
    let sdDragonite = SDPokemon(pokemonID: dragonite.id, data: try? JSONEncoder().encode(dragonite))
    preview.addExamples([sdDragonite])
    return PokemonAbilitySelectionScreen(provider: .init(pokemonID: sdDragonite.persistentModelID, api: .init(), abilities: dragonite.abilities, selected: nil, modelContext: preview.container.mainContext))
        .inject(container: container)
        .preferredColorScheme(.dark)
        .modelContainer(preview.container)
}
