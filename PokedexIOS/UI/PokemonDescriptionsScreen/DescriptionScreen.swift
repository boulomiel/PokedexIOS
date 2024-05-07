//
//  DescriptionView.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 21/04/2024.
//

import SwiftUI

struct DescriptionScreen: View {
    
    let descriptions: [DescriptionByVersionModel]
    @State var selectedLanguage: String
    
    private let grid: [GridItem] = [GridItem(.fixed(80), spacing: 0), GridItem(.flexible(minimum: 250, maximum: 300))]
    private var languages: [String] {
        Array(Set(descriptions.map(\.language))).sorted()
    }
    private var filtered: [DescriptionByVersionModel] {
        descriptions.filter { $0.language == selectedLanguage }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ScrollPickerView(options: languages, selected: $selectedLanguage)
                Grid {
                    GridRow {
                        headerText("Versions")
                            .gridCellColumns(1)
                        headerText("Description")
                            .gridCellColumns(3)
                    }
                    ForEach(filtered, id: \.id) { description in
                        GridRow {
                            Text(description.readableVersion)
                                .bold()
                                .minimumScaleFactor(0.1)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .overlay(alignment: .bottom) {
                                    bottomLine
                                }
                                .gridCellColumns(1)

                            
                            Text(description.readableDescription)
                                .font(.callout)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .multilineTextAlignment(.leading)
                                .padding(.vertical, 4)
                                .overlay(alignment: .bottom) {
                                    bottomLine
                                }
                                .gridCellColumns(3)

                        }
                    }
                }
            }
            Spacer()
        }
    }
    
    func headerText(_ title: String) -> some View {
        Text(title)
            .bold()
            .frame(maxWidth: .infinity)
            .padding(.vertical, 4)
            .overlay(alignment: .bottom) {
                bottomLine
            }
    }
    
    var bottomLine: some View {
        Rectangle()
            .fill(Color.white.opacity(0.3))
            .frame(height: 1)
    }
    
    var sideLine: some View {
        Rectangle()
            .fill(Color.white.opacity(0.3))
            .frame(width: 1)
    }
}

#Preview {
    let descriptions: [DescriptionByVersionModel] = [
        .init(version: "red", description: "When several of these POKéMON gather, their felectricity could build and cause lightning storms.", language: "en"),
        .init(version: "blue", description: "It keeps its tail raised to monitor its surroundings.If you yank its tail, it will try to bite you.", language: "en"),
        .init(version: "x", description: "Solleva la coda per esaminare l’ambiente circostante.A volte la coda è colpita da un fulmine quando è in questa posizione.", language: "it"),
        .init(version: "omega-ruby", description: "Immer wenn Pikachu auf etwas Neues stößt, jagt es\neinen Elektroschock hindurch. Wenn du eine verkohlte\nBeere findest, hat dieses Pokémon seine elektrische\nLadung falsch eingeschätzt.", language: "ger"),
        .init(version: "omega-ruby", description: "はじめて　みる　ものには　電撃を　当てる。\n黒こげの　きのみが　落ちていたら　それは\n電撃の　強さを　間違えた　証拠だよ。", language: "ja")
    ]
    return DescriptionScreen(descriptions: descriptions, selectedLanguage: descriptions.first?.language ?? "" )
    .preferredColorScheme(.dark)
}
