//
//  SearchView.swift
//  My Movie App (iOS)
//
//  Created by Tuyen Le on 1/20/22.
//

import SwiftUI
import TMDBAPI

@MainActor
class SearchViewViewModel: ObservableObject {
    let searchDB = SearchDB()
    @Published var searchResult: [MultiSearch.Result] = []
    @Published var searchText: String = ""

    func search() async throws {
        if searchText.isEmpty {
            searchResult = []
        } else {
            searchResult = try await searchDB.multiSearch(includeAdult: true, query: searchText).get().results.filter { !$0.title.isEmpty }
        }
    }
}

struct SearchView: View {
    var searchResult: [MultiSearch.Result]

    var body: some View {
        ForEach(searchResult) { item in
            NavigationLink(destination: Text(item.title)) {
                HStack(alignment: .center, spacing: 20) {
                    AsyncImage(url: URL(string: item.posterLink), transaction: Transaction(animation: .linear)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 50, height: 100, alignment: .leading)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 80)
                        case .failure:
                            Image(uiImage: UIImage(named: "NoImage")!)
                                .resizable()
                                .frame(width: 40, height: 80)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    VStack(alignment: .leading, spacing: 5) {
                        Text(item.title)
                            .font(.headline)
                        Text(item.overview)
                            .lineLimit(2)
                            .font(.body)
                    }
                }
            }
            .buttonStyle(.plain)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchResult: [])
    }
}
