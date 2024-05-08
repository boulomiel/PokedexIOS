//
//  ItemCell.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 01/05/2024.
//

import Foundation
import SwiftUI

public struct ItemCell: View {
    
    @State var provider: Provider
    var onSelect: ((Item?) -> Void)? = nil
    var onDeselect: ((Item?) -> Void)? = nil

    public var body: some View {
        GroupBox {
            Group {
                if let description = provider.description {
                    Text(description)
                        .font(.caption)
                        .bold()
                } else {
                    textPlaceholder
                }
            }
        } label: {
            Label(
                title: {
                    Text(provider.itemName)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                },
                icon: {
                    Circle()
                        .fill(.ultraThinMaterial)
                        .frame(width: 80, height: 80)
                        .overlay {
                            ScaleAsyncImage(url: provider.sprite)
                        }
                }
            )
        }
        .onSelection(isSelected: $provider.isSelected, isSelectable: provider.isSelectable, alignment: .topTrailing, padding: .init(top: 8, leading: 0, bottom: 0, trailing: 8))
        .background(RoundedRectangle(cornerRadius: 8).fill(.ultraThinMaterial))
        .onTapGesture {
            guard provider.isSelectable else { return }
            provider.isSelected.toggle()
            if provider.isSelected {
                onSelect?(provider.item)
            } else {
                onDeselect?(provider.item)
            }
        }
    }
    
    var textPlaceholder: some View {
        VStack(alignment: .leading, spacing: 4) {
            Rectangle()
                .fill(.ultraThinMaterial)
                .frame(width: 200, height: 5)
            Rectangle()
                .fill(.ultraThinMaterial)
                .frame(width: 50, height: 5)
            Rectangle()
                .fill(.ultraThinMaterial)
                .frame(width: 140, height: 5)
            Rectangle()
                .fill(.ultraThinMaterial)
                .frame(width: 160, height: 5)
        }
    }
    
    @Observable
   public class Provider: Identifiable {
        
        public let id: UUID = .init()
        let api: PokemonItemApi
        let scrolledFetchedItem: NamedAPIResource?
        var isSelectable: Bool
        var isSelected: Bool
        var item: Item?
        var onItemSet: ((Item, Provider) -> Void)?
        
        private var languageName: LanguageName
        
        var sprite: URL? {
            item?.sprites.defaultSprite
        }
        
        var itemName: String {
            if case let .en(englishName) = languageName {
                return englishName.capitalized
            } else {
                return languageName.foreign.capitalized
            }
        }
        
        var description: String? {
            item?.flavorTextEntries.first(where: { $0.language.name == languageName.language })?.text ?? item?.flavorTextEntries.first(where: { $0.language.name == "en" })?.text
                .trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\n", with: " ")
        }
    
        init(api: PokemonItemApi, scrolledFetchedItem: NamedAPIResource, isSelectable: Bool = false, onItemSet: ((Item, Provider) -> Void)? = nil) {
            self.api = api
            self.scrolledFetchedItem = scrolledFetchedItem
            self.isSelectable = isSelectable
            self.isSelected = false
            self.onItemSet = onItemSet
            self.languageName = .en(englishName: scrolledFetchedItem.name)
            Task {
                await fetch()
            }
        }
        
        init(api: PokemonItemApi, item: Item, languageName: LanguageName, isSelectable: Bool = false, onItemSet: ((Item, Provider) -> Void)? = nil) {
            self.api = api
            self.item = item
            self.scrolledFetchedItem = nil
            self.isSelectable = isSelectable
            self.isSelected = false
            self.onItemSet = onItemSet
            self.languageName = languageName
        }
        
        func fetch() async {
            guard let scrolledFetchedItem else { return }
            let result = await api.fetch(id: scrolledFetchedItem.name)
            switch result {
            case .success(let success):
                await MainActor.run {
                    self.item = success
                    onItemSet?(success, self)
                }
            case .failure(let failure):
                print(#file,"\n", #function, failure)
            }
        }
        
//        func shouldRemove() -> Bool {
//            guard let item else { return false }
//            switch item.categoryType.name {
//            case .heldItems, .badHeldItems, .zCrystals, .teraShard, .typeEnhancement, .megaStones, .dynamaxCrystals:
//                return false
//            default:
//                return true
//            }
//        }
    }
}

