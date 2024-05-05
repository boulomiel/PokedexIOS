//
//  PokemonScrollList.swift
//  PokedexIOS
//
//  Created by Ruben Mimoun on 17/04/2024.
//

import Foundation
import SwiftUI
import Combine

struct PaginatedList<Scroller: View, ScrollService: ScrollFetchApiProtocol, ApiService: SearchApiProtocol> : View where ScrollService.Requested == ScrollFetchResult {
    
    typealias Provider = ScrollProvider<ScrollService, ApiService>

    @State var provider: Provider
    @ViewBuilder var scroller: (Provider) -> Scroller
    
    var body: some View {
        scroller(provider)
            .searchable(text: $provider.config.searchText)
            .autocorrectionDisabled(true) 
            .onChange(of: provider.config.searchText, { oldValue, newValue in
                provider.onSearch(newValue: newValue.replacingOccurrences(of: " ", with: "-"))
            })
            .animation(.bouncy, value: provider.config.searchText)
    }
    
    @Observable
    class ScrollProvider<ScrollApi: ScrollFetchApiProtocol, Api: SearchApiProtocol> where ScrollApi.Requested == ScrollFetchResult {
        var subscriptions: Set<AnyCancellable> = .init()
        let scrollFetchApi: ScrollApi
        let fetchApi: Api
        var searchTask: Task<Void, Never>?
        var config: Config
        var searched: Api.Requested?
        
        init(api: ScrollApi, fetchApi: Api, config: Config = .init()) {
            self.scrollFetchApi = api
            self.fetchApi = fetchApi
            self.config = config
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
                    //print(#function, error)
                }
            }
        }
        
        private func fetch() async {
            let result = await scrollFetchApi.fetch(session: .shared, offset: config.currentOffset)
            switch result {
            case .success(let success):
                await MainActor.run {
                    withAnimation {
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
            let result = await fetchApi.fetch(id: name)
            switch result {
            case .success(let result):
                await MainActor.run {
                    searched = result
                }
            case .failure(let error):
                searched = nil
                print(#function, error)
            }
        }
        
        private func cleanSearchTask() {
            searched = nil
            searchTask?.cancel()
            searchTask = nil
        }
        
        struct Config {
            var searchText: String = ""
            var scrollFetch: [ScrolledFetchedElement] = []
            var currentOffset: Int = 0
            
            var list: [EnumeratedSequence<[ScrolledFetchedElement]>.Element] {
                if searchText == "" {
                    return Array(scrollFetch.enumerated())
                } else {
                    let filtered = scrollFetch.filter { $0.name.starts(with: searchText.lowercased()) }
                    return Array(filtered.enumerated())
                }
            }
            
            var fetchCount: Int {
                scrollFetch.count
            }
        }
    }

}
