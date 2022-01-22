//
//  ContentView.swift
//  Shared
//
//  Created by Tuyen Le on 1/12/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel = HomeViewViewModel()
    @StateObject var searchViewModel = SearchViewViewModel()

    var body: some View {
        NavigationView {
            List {
                Section {
                    SearchView(searchResult: searchViewModel.searchResult)
                }
                .listStyle(.plain)
                .listRowSeparator(.hidden)
                .listRowSeparatorTint(.clear)
                
                if searchViewModel.searchText.isEmpty {
                    HStack(alignment: .center, spacing: 20) {
                        Button {
                            homeViewModel.selected(.movie)
                        } label: {
                            Text("Movie")
                                .font(.title)
                                .shouldUnderline(homeViewModel.shouldUnderline)
                        }
                        Button {
                            homeViewModel.selected(.tvshow)
                        } label: {
                            Text("TV Show")
                                .font(.title)
                                .shouldUnderline(!homeViewModel.shouldUnderline)
                        }
                    }
                    .padding(.bottom)
                    .buttonStyle(.plain)
                    .isHidden(homeViewModel.hidePresentView)
                    .listRowSeparator(.hidden)
                    .listRowSeparatorTint(.clear)

                    Section {
                        LatestEntityView(displayObject: homeViewModel.latest)
                            .padding(.bottom)

                        LazyVStack(alignment: .leading) {
                            NavigationLink(destination: SeeAllView(navigationTitle: homeViewModel.text)) {
                                Text(homeViewModel.text)
                                    .bold()
                            }
                            ScrollView(.horizontal, showsIndicators: false) {
                                EntityHStack(displayObjects: homeViewModel.displayObjects)
                            }
                        }
                        .padding(.bottom)

                        LazyVStack(alignment: .leading) {
                            NavigationLink(destination: SeeAllView(navigationTitle: homeViewModel.text1)) {
                                Text(homeViewModel.text1)
                                    .bold()
                            }
                            ScrollView(.horizontal, showsIndicators: false) {
                                EntityHStack(displayObjects: homeViewModel.displayObjects1)
                            }
                        }
                        .padding(.bottom)

                        LazyVStack(alignment: .leading) {
                            NavigationLink(destination: SeeAllView(navigationTitle: homeViewModel.text2)) {
                                Text(homeViewModel.text2)
                                    .bold()
                            }
                            ScrollView(.horizontal, showsIndicators: false) {
                                EntityHStack(displayObjects: homeViewModel.displayObjects2)
                            }
                        }
                        .padding(.bottom)

                        LazyVStack(alignment: .leading) {
                            NavigationLink(destination: SeeAllView(navigationTitle: homeViewModel.text3)) {
                                Text(homeViewModel.text3)
                                    .bold()
                            }
                            ScrollView(.horizontal, showsIndicators: false) {
                                EntityHStack(displayObjects: homeViewModel.displayObjects3)
                            }
                        }
                        .padding(.bottom)

                    }
                    .listStyle(.plain)
                    .listRowSeparator(.hidden)
                    .listRowSeparatorTint(.clear)
                    .isHidden(homeViewModel.hidePresentView)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchViewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search") {
                EmptyView()
            }
            .onChange(of: searchViewModel.searchText) { _ in
                Task {
                    try? await searchViewModel.search()
                }
            }
            .refreshable {
                try? await homeViewModel.refresh()
            }
        }
        .disabled(homeViewModel.hidePresentView)
        .task {
            try? await homeViewModel.initialFetch()
        }
        .overlay {
            PendingStateView(hideInitialProgressView: homeViewModel.hideInitialProgressView,
                             hideError: homeViewModel.hideError,
                             action: homeViewModel.refresh)
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
