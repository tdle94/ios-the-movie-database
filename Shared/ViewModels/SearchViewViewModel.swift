//
//  SearchViewViewModel.swift
//  My Movie App (iOS)
//
//  Created by Tuyen Le on 1/22/22.
//

import Foundation
import TMDBAPI

@MainActor
class SearchViewViewModel: ObservableObject {
    let searchDB = SearchDB()
    @Published var searchResult: [MultiSearch.Result] = []
    @Published var searchText: String = ""
    private(set) var oldSearchText: String = ""
    private(set) var loadMore: Bool = false
    private(set) var isFetching: Bool = false
    private(set) var currentPage: Int = 0
    private(set) var maxPage: Int = -1

    func search() async throws {
        guard !isFetching else { return }
        guard currentPage != maxPage else {
            loadMore = false
            return
        }
        
        defer {
            isFetching = false
        }

        isFetching = true
        
        if searchText != oldSearchText {
            oldSearchText = searchText
            searchResult = []
            currentPage = 0
        }

        if searchText.isEmpty {
            searchResult = []
            loadMore = false
        } else {
            let response = try await searchDB.multiSearch(page: currentPage + 1, includeAdult: true, query: searchText).get()
            searchResult.append(contentsOf: response.results.filter { !$0.title.isEmpty })
            maxPage = response.totalPages

            if currentPage + 1 <= maxPage {
                currentPage += 1
                loadMore = currentPage != maxPage
            } else if maxPage == 0 {
                currentPage = 0
                maxPage = -1
                loadMore = false
            }
        }
    }
}
