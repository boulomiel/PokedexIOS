//
//  PokemonScrollList.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation
import SwiftUI
import Combine
import SwiftData
import DI
import Dtos

public struct PaginatedList<Scroller: View, ScrollService: ScrollFetchApiProtocol, ApiService: SearchApiProtocol> : View where ScrollService.Requested == ScrollFetchResult {
    
    typealias Provider = ScrollProvider<ScrollService, ApiService>
    
    @State var provider: Provider
    @ViewBuilder var scroller: (Provider) -> Scroller
    
    public var body: some View {
        scroller(provider)
            .searchable(text: $provider.config.searchText)
            .autocorrectionDisabled(true)
            .onChange(of: provider.config.searchText, { oldValue, newValue in
                provider.onSearch(newValue: newValue)
            })
            .animation(.bouncy, value: provider.config.searchText)
    }
    
    @Observable @MainActor
    public class ScrollProvider<ScrollApi: ScrollFetchApiProtocol, Api: SearchApiProtocol> where ScrollApi.Requested == ScrollFetchResult, Api.Requested: Sendable {
        var subscriptions: Set<AnyCancellable> = .init()
        let scrollFetchApi: ScrollApi
        let fetchApi: Api
        var searchTask: Task<Void, Never>?
        var config: Config
        var searched: [SearchedElement<Api.Requested>]?
        var container: ModelContainer
        var languageNameFetcher: LanguageNameFetcher
        
        init(api: ScrollApi, fetchApi: Api, modelContainer: ModelContainer, languageNameFetcher: LanguageNameFetcher, config: Config = .init()) {
            self.scrollFetchApi = api
            self.fetchApi = fetchApi
            self.config = config
            self.container = modelContainer
            self.languageNameFetcher = languageNameFetcher
            Task {
                await fetch()
            }
        }
        
        func update(from index: Int) {
            if index == config.fetchCount-1 {
                config.currentOffset += 50
                Task {
                    await fetch()
                }
            }
        }
        
        func onSearch(newValue: String) {
            cleanSearchTask()
            searchTask = Task {
                do {
                    try await Task.sleep(for: .seconds(0.3))
                    await fetch(for: newValue.lowercased())
                } catch {
                    //print(#file, #function, error)
                }
            }
        }
        
        private func fetch() async {
            let result = await scrollFetchApi.fetch(session: .shared, offset: config.currentOffset)
            switch result {
            case .success(let success):
                await MainActor.run {
                    withAnimation(.smooth) {
                        self.config.scrollFetch.append(contentsOf: success.results)
                    }
                }
            case .failure(let failure):
                print(failure)
            }
        }
        
        private func fetch(for name: String) async {
            guard !name.isEmpty else {
                cleanSearchTask()
                return
            }
            let englishNames = fetchApi is PokemonItemApi ? languageNameFetcher.fetchItemNames(for: name) : languageNameFetcher.fetchPokemonNames(for: name)
            if englishNames.isEmpty {
                let result = await fetchApi.fetch(id: name.lowercased().replacingOccurrences(of: " ", with: "-"))
                switch result {
                case .success(let result):
                    await MainActor.run {
                        withAnimation(.smooth) {
                            searched = [.init(element: result, language: .en(englishName: name))]
                        }
                    }
                case .failure(let error):
                    withAnimation(.smooth) {
                        searched = nil
                    }
                    print(#file, #function, error, name)
                }
            } else {
                let searched = await withTaskGroup(of: SearchedElement?.self) { group in
                    englishNames.forEach { name in
                        group.addTask {
                            let result = await self.fetchApi.fetch(id: name.english.lowercased().replacingOccurrences(of: " ", with: "-"))
                            switch result {
                            case .success(let result):
                                return .init(element: result, language: name)
                            case .failure(let error):
                                print(#file, #function, error, name, name.english.lowercased())
                                return nil
                            }
                        }
                    }
                    var result = [SearchedElement<Api.Requested>]()
                    for await element in group {
                        if let element {
                            result.append(element)
                        }
                    }
                    return result
                }
                await MainActor.run {
                    withAnimation(.smooth) {
                        self.searched = searched
                    }
                }
            }
        }
        
        private func cleanSearchTask() {
            searched = nil
            searchTask?.cancel()
            searchTask = nil
        }
        
        public struct Config {
            var searchText: String = ""
            var scrollFetch: [NamedAPIResource] = []
            @ObservationIgnored var currentOffset: Int = 0
            
            var list: [EnumeratedSequence<[NamedAPIResource]>.Element] {
                Array(scrollFetch.enumerated())
            }
            
            var fetchCount: Int {
                scrollFetch.count
            }
        }
        
        public struct SearchedElement<Content: Codable & Sendable>: Sendable {
            let element: Content
            let language: LanguageName
        }
    }
}

protocol NameFetchingProtocol {
    associatedtype ItemApi
    func fetchNameForLanguage(for name: String) async -> String?
}

public struct AnyNameFetchingProvider<ItemApi>: NameFetchingProtocol {
    private let _fetchNameForLanguage: (String) async -> String?
    
    init<T: NameFetchingProtocol>(_ provider: T) where T.ItemApi == ItemApi {
        _fetchNameForLanguage = provider.fetchNameForLanguage
    }
    
    func fetchNameForLanguage(for name: String) async -> String? {
        return await _fetchNameForLanguage(name)
    }
}
