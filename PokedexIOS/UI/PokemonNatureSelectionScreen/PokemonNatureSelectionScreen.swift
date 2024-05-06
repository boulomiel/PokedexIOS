//
//  PokemonNatureSelectionScreen.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 28/04/2024.
//

import Foundation
import SwiftUI
import SwiftData

struct PokemonNatureSelectionScreen: View {
    
    @Environment(\.dismiss) var dimiss
    let provider: Provider
    
    var body: some View {
        VStack {
            if provider.natures.isEmpty {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.ultraThinMaterial)
                    .frame(height: 80)
                    .overlay {
                        ProgressView()
                    }
            } else {
                if let selectedLanguage = provider.selectedLanguage {
                    ScrollPickerView(options: provider.languages, selected: Binding(get: { selectedLanguage }, set: { provider.selectedLanguage = $0 }))
                }
                
                if let selected = provider.selected {
                    let array = provider.natures
                    naturePickerView(selected, natures: Array(array[0..<5]))
                    naturePickerView(selected, natures: Array(array[5..<10]))
                    naturePickerView(selected, natures: Array(array[15..<20]))
                    naturePickerView(selected, natures: Array(array[20...]))
                }
            }
            
            statView
        }
        .toolbar {
            Button(action: {
                provider.save()
                Vibrator.notify(of: .success)
                dimiss.callAsFunction()
            }, label: {
                Text("Save")
            })
        }
        .onChange(of: provider.selected) { oldValue, newValue in
            if let selected = newValue {
                provider.updateStat(with: selected)
            }
        }
    }
    
    func languagePickerView(_ selected: String) -> some View {
        Picker(selection: Binding(get: { selected }, set: { provider.selectedLanguage = $0 })) {
            ForEach(provider.languages, id:\.self) { language in
                Text(language.capitalized)
                    .tag(language)
            }
        } label: {
            Text("Languages")
        }
        .pickerStyle(.palette)
    }
    
    func naturePickerView(_ selected: Nature, natures: [Nature]) -> some View {
        Picker(selection: Binding(get: { selected }, set: { provider.selected = $0 })) {
            ForEach(natures, id:\.id) { nature in
                Text(nature.names.first(where: { $0.language.name == provider.selectedLanguage })?.name ?? "")
                    .tag(nature)
            }
        } label: {
            Text("Natures")
        }
        .pickerStyle(.palette)
    }
    
    var statView: some View {
        PokemonStatsView(
            pokemonStats: provider.stats,
            backgroundColor: .white.opacity(
                0.2
            ),
            dataColor: .blue,
            strokeLine: .blue
        )
        .padding(.vertical, 15)
    }
    
    @Observable
    class Provider {
        let api: PokemonNatureApi
        let pokemonID: PersistentIdentifier
        var stats: [PokemonDisplayStat]
        let modelContext: ModelContext
        
        @ObservationIgnored private var bastStats: [PokemonDisplayStat]
        @ObservationIgnored private var current: Nature?
        var languages: [String]
        var natures: [Nature]
        var selected: Nature?
        var selectedLanguage: String?
        
        init(api: PokemonNatureApi, pokemonID: PersistentIdentifier, stats: [PokemonStat], current: Nature?, modelContext: ModelContext) {
            self.api = api
            self.pokemonID = pokemonID
            let displaysStats = stats.map { stat in
                PokemonDisplayStat(name: stat.stat.name, value: Double(stat.baseStat)/200) // max pokemon stat 255
            }
            self.stats = displaysStats
            self.bastStats = displaysStats
            self.natures = []
            self.languages = []
            self.modelContext = modelContext
            self.current = current
            Task {
                await fetch()
            }
        }
        
        private func fetch() async {
            let natures = await withTaskGroup(of: Nature?.self) { group in
                for i in 0..<PokemonNatureQuery.natureRange {
                    group.addTask { [weak self] in
                        await self?.fetch(id: "\(i)")
                    }
                }
                
                let reduced = await group.reduce(into: [Nature]()) { partialResult, nature in
                    if let nature {
                        partialResult.append(nature)
                    }
                }
                return reduced
            }
            
            let languages = Array(Set(natures.flatMap(\.names).map(\.language.name)))
            await MainActor.run {
                self.languages = languages
                self.selectedLanguage = languages.first
                self.natures = natures.sorted(by: { $0.name < $1.name })
                self.selected =  current ?? natures.first!
                updateStat(with: selected!)
            }
        }
        
        private func fetch(id: String) async -> Nature? {
            let result = await api.fetch(query: .init(id: id))
            switch result {
            case .success(let success):
                return success
            case .failure(let failure):
                print(#file, #function, failure)
                return nil
            }
        }
        
        func updateStat(with nature: Nature) {
            let bridge = NatureStatBridge(natureName: nature.name, improvedStat: nature.increased_stat?.name, decreasedStat: nature.decreased_stat?.name)
            stats = bastStats
            stats = stats.map({ stat in
                var stat = stat
                if stat.name == bridge.improvedStat {
                    stat.value *= 1.10
                }
                if stat.name == bridge.decreasedStat {
                    stat.value *= 0.90
                }
                return stat
            })
            Vibrator.selection()
        }
        
        func save() {
            guard let selected else { return }
            let pokemon = modelContext.fetchUniqueSync(SDPokemon.self ,with: pokemonID)
            pokemon?.nature = SDNature(natureID: selected.id, data: try? JSONEncoder().encode(selected))
        }
    }
}

struct NatureStatBridge {
    let natureName: String
    let improvedStat: String?
    let decreasedStat: String?
}

#Preview {
    @Environment(\.diContainer) var container
    let preview = Preview.allPreview
    let pokemon = JsonReader.readPokemons().randomElement()!
    
    let sdPokemon = SDPokemon(pokemonID: pokemon.id, data: try? JSONEncoder().encode(pokemon))
    preview.addExamples([sdPokemon])
    return PokemonNatureSelectionScreen(provider: .init(api: .init(), pokemonID: sdPokemon.persistentModelID, stats: pokemon.stats, current: nil, modelContext: preview.container.mainContext))
    .inject(container: container)
    .modelContainer(preview.container)
    .preferredColorScheme(.dark)
}

