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
    @State private var action: Bool = false
    @State private var action1: Bool = false
    @State private var action2: Bool = false
    @State private var action3: Bool = false

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

                LazyVStack {
                    LatestEntityView(displayObject: viewModel.latest)
                        .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(viewModel.text)
                                .bold()
                            NavigationLink(destination: SeeAllView(text: "text"), isActive: $action) {
                                EmptyView()
                            }
                        }
                        .onTapGesture {
                            action = true
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            EntityHStack(displayObjects: viewModel.displayObjects)
                        }
                    }
                    .padding(.bottom)


                    VStack(alignment: .leading) {
                        HStack {
                            Text(viewModel.text1)
                                .bold()
                            NavigationLink(destination: SeeAllView(text: "text1"), isActive: $action1) {
                                EmptyView()
                            }
                        }
                        .onTapGesture {
                            action1 = true
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            EntityHStack(displayObjects: viewModel.displayObjects1)
                        }
                    }
                    .padding(.bottom)

                    VStack(alignment: .leading) {
                        HStack {
                            Text(viewModel.text2)
                                .bold()
                            NavigationLink(destination: SeeAllView(text: "text2"), isActive: $action2) {
                                EmptyView()
                            }
                        }
                        .onTapGesture {
                            action2 = true
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            EntityHStack(displayObjects: viewModel.displayObjects2)
                        }
                    }
                    .padding(.bottom)

                    VStack(alignment: .leading) {
                        HStack {
                            Text(viewModel.text3)
                                .bold()
                            NavigationLink(destination: SeeAllView(text: "text3"), isActive: $action3) {
                                EmptyView()
                            }
                        }
                        .onTapGesture {
                            action3 = true
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
