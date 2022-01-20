//
//  ContentView.swift
//  Shared
//
//  Created by Tuyen Le on 1/12/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewViewModel()
    @State var searchText: String = ""

    var body: some View {
        NavigationView {
            List {
                HStack(alignment: .center, spacing: 20) {
                    Button {
                        viewModel.selected(.movie)
                    } label: {
                        Text("Movie")
                            .font(.title)
                            .shouldUnderline(viewModel.shouldUnderline)
                    }
                    Button {
                        viewModel.selected(.tvshow)
                    } label: {
                        Text("TV Show")
                            .font(.title)
                            .shouldUnderline(!viewModel.shouldUnderline)
                    }
                }
                .padding(.bottom)
                .buttonStyle(.plain)
                .isHidden(viewModel.hidePresentView)
                .listRowSeparator(.hidden)
                .listRowSeparatorTint(.clear)

                Section {
                    LatestEntityView(displayObject: viewModel.latest)
                        .padding(.bottom)

                    LazyVStack(alignment: .leading) {
                        NavigationLink(destination: SeeAllView(navigationTitle: viewModel.text)) {
                            Text(viewModel.text)
                                .bold()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            EntityHStack(displayObjects: viewModel.displayObjects)
                        }
                    }
                    .padding(.bottom)

                    LazyVStack(alignment: .leading) {
                        NavigationLink(destination: SeeAllView(navigationTitle: viewModel.text1)) {
                            Text(viewModel.text1)
                                .bold()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            EntityHStack(displayObjects: viewModel.displayObjects1)
                        }
                    }
                    .padding(.bottom)

                    LazyVStack(alignment: .leading) {
                        NavigationLink(destination: SeeAllView(navigationTitle: viewModel.text2)) {
                            Text(viewModel.text2)
                                .bold()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            EntityHStack(displayObjects: viewModel.displayObjects2)
                        }
                    }
                    .padding(.bottom)

                    LazyVStack(alignment: .leading) {
                        NavigationLink(destination: SeeAllView(navigationTitle: viewModel.text3)) {
                            Text(viewModel.text3)
                                .bold()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            EntityHStack(displayObjects: viewModel.displayObjects3)
                        }
                    }
                    .padding(.bottom)

                }
                .listStyle(.plain)
                .listRowSeparator(.hidden)
                .listRowSeparatorTint(.clear)
                .isHidden(viewModel.hidePresentView)
            }
            .listStyle(.plain)
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .refreshable {
                try? await viewModel.refresh()
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
        .disabled(viewModel.hidePresentView)
        .task {
            try? await viewModel.initialFetch()
        }
        .overlay {
            PendingStateView(hideInitialProgressView: viewModel.hideInitialProgressView,
                             hideError: viewModel.hideError,
                             action: viewModel.refresh)
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
