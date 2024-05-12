//
//  PokemonTeamPreview.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 24/04/2024.
//

import SwiftUI
import Resources
import Tools
import DI
import Dtos

public struct PokemonTeamPreviewScreen: View {
    
    @Environment(TeamRouter.self) var teamRouter
    @Environment(\.modelContext) var modelContext
    @DIContainer var player: CriePlayer
    let pokemon: SDPokemon
    
    var moves: [Move] {
        pokemon.moves?.compactMap { $0.decoded }.sorted(by: {$0.id < $1.id}) ?? []
    }
    
    var stats: [PokemonStat] {
        pokemon.decoded?.stats ?? []
    }
    
    var item: Item? {
        pokemon.item?.decoded
    }
    
    var types: [PokemonType.PT] {
        pokemon.decoded?.types.pt ?? []
    }
    
    public var body: some View {
        Form {
            VStack {
                HStack {
                    Text(pokemon.decoded?.name.capitalized ?? "")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    typeView
                }
                
                ScaleAsyncImage(url: pokemon.decoded?.sprites?.frontDefault, width: 200, height: 200)
                    .background(Circle().fill(Color.gray.opacity(0.3)))
            }
            .overlay(alignment: .bottomTrailing) {
                VStack {
                    let itemName = item?.name ?? "Item"
                    ShrinkText(text: itemName.uppercased(), alignment: .center, font: .caption.bold(), width: 50)
                        .foregroundStyle(.white.opacity(0.3))
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 50, height: 50)
                        .overlay {
                            itemButton
                        }
                }
            }
            
            Section(content: {
                abilityContent
            }, header: {
                abilityHeader
            })
            
            Section(content: {
                natureContent
            }, header: {
                natureHeader
            })

            Section(content: {
                movesContent
            }, header: {
                movesHeader
            })

        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    teamRouter.back()
                } label: {
                    Label("Teams", systemImage: "chevron.left")
                }
            }
        }
        .pokemonTypeBackgroundV(types: types)
        .scrollContentBackground(.hidden)
        .task {
            let crie = pokemon.decoded?.cries
            await player.play(crie?.latest ?? crie?.legacy)
        }
    }
    
    var itemButton: some View {
        Button {
            teamRouter.navigate(to: AddItemRoute(pokemonID: pokemon.persistentModelID, item: pokemon.item?.decoded))
        } label: {
            if let item = item {
                ScaleAsyncImage(url: item.sprites.defaultSprite)
            } else {
                Image(systemName: "plus")
                    .bold()
            }
        }
        .buttonStyle(.plain)
        .foregroundStyle(.white.opacity(0.6))
    }
    
    var natureHeader: some View {
        SectionHeader("Nature", route: getNatureRoute)
    }
    
    @ViewBuilder
    var natureContent: some View {
        if let nature = pokemon.nature?.decoded {
            Text(nature.name.capitalized)
                .bold()
        } else {
            NavigationLink("Add Nature", value: getNatureRoute)
        }
    }
    
    var abilityHeader: some View {
        SectionHeader("Ability", route: getAbilityRoute)
    }
    
    @ViewBuilder
    var abilityContent: some View {
        let ability = pokemon.ability?.decoded
        if let ability {
            Text(ability.name.capitalized)
                .bold()
        } else {
            NavigationLink("Add Ability", value: getAbilityRoute)
        }
    }
    
    @ViewBuilder
    var movesContent: some View {
        if moves.isEmpty {
            NavigationLink("Add move", value: getMoveRoute)
        } else {
            MoveSectionContentCell(moves: moves)
        }
    }
    
    var movesHeader: some View {
        SectionHeader("Moves", route: getMoveRoute)
    }
    
    func SectionHeader<Route: Hashable>(_ title: String, route: Route) -> some View {
        HStack {
            Text(title)
            Spacer()
            Button(action: {
                teamRouter.navigate(to: route)
            }, label: {
                Image(systemName: "square.and.pencil")
            })
            .buttonStyle(.plain)
            .foregroundStyle(.blue)
        }
    }
    
    @ViewBuilder
    var typeView: some View {
        if let types = pokemon.decoded?.types.pt {
            PokemonTypeListView(types: types, imageSize: 35)
        }
    }
    
    var getMoveRoute: AddAttackRoute {
        let urls: [URL] =  pokemon.decoded?.moves.compactMap { $0.move.url } ?? []
        return AddAttackRoute(pokemonID: pokemon.persistentModelID, movesURL: urls, selectedMoves: moves)
    }
    
    var getAbilityRoute: AddAbilityRoute {
        let abilities = pokemon.decoded?.abilities ?? []
        let current = makeModel(from: pokemon.ability?.decoded)
        return AddAbilityRoute(pokemonID: pokemon.persistentModelID, abilities: abilities, current: current)
    }
    
    var getNatureRoute: AddNatureRoute {
        let nature = pokemon.nature?.decoded
        return AddNatureRoute(pokemonID: pokemon.persistentModelID, stats: stats, current: nature)
    }
    
    private func makeModel(from success: Ability?) -> PokemonAbilitySelectionModel? {
        guard let success = success else { return nil }
        let effectChange = success.effectChanges
            .flatMap(\.effectEntries)
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
}

#Preview {
    @Environment(\.diContainer) var container
    let preview = Preview.allPreview
    
    let dragonite: Pokemon = JsonReader.read(for: .dragonite)
    let sdDragonite = SDPokemon(pokemonID: dragonite.order, data: try! JSONEncoder().encode(dragonite))
   // let team = SDTeam(teamID: id, name: "Test")
  //  preview.addExamples([team])
    preview.addExamples([sdDragonite])
   // team.pokemons = [sdDragonite]
    return PokemonTeamPreviewScreen(pokemon: sdDragonite)
        .environment(TeamRouter())
        .modelContainer(preview.container)
        .inject(container: container)
        .preferredColorScheme(.dark)
}
