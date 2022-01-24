//
//  EntityDetailView.swift
//  My Movie App (iOS)
//
//  Created by Tuyen Le on 1/20/22.
//

import SwiftUI

struct EntityDetailView: View {
    @StateObject var viewModel: EntityDetailViewViewModel

    var body: some View {
        List {
            AsyncImage(url: URL(string: viewModel.entityDetail.posterLink), transaction: Transaction(animation: .linear)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .frame(minWidth: 100, idealWidth: 200, maxWidth: .infinity, minHeight: 200, idealHeight: 300, maxHeight: .infinity, alignment: .leading)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .aspectRatio(1, contentMode: .fit)
                case .failure:
                    Image(uiImage: UIImage(named: "NoImage")!)
                        .resizable()
                        .frame(minWidth: 100, idealWidth: 200, maxWidth: .infinity, minHeight: 200, idealHeight: 300, maxHeight: .infinity, alignment: .leading)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .aspectRatio(1, contentMode: .fit)
                @unknown default:
                    EmptyView()
                }
            }
            .listRowSeparator(.hidden)
            .padding(.top)
            .padding(.leading, 0)

            Text(viewModel.entityDetail.titleWithYear)
                .font(.title2)
                .listRowSeparator(.hidden)
            
            if !viewModel.entityDetail.tagline.isEmpty {
                Text(viewModel.entityDetail.tagline)
                    .font(.body)
                    .italic()
                    .padding(.top)
            }

            if !viewModel.entityDetail.overview.isEmpty {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Overview")
                        .font(.headline)
                    
                    Text(viewModel.entityDetail.overview)
                        .font(.body)
                }
                .listRowSeparator(.hidden)
                .padding(.top)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                NavigationLink(destination: AllImageView(navigationTitle: viewModel.mediaType.rawValue)) {
                    HStack {
                        Text("Media")
                            .font(.headline)
                        
                        HStack(alignment: .firstTextBaseline, spacing: 10) {
                            Button {
                                viewModel.selectMediaType(.backdrop)
                            } label: {
                                HStack(alignment: .firstTextBaseline, spacing: 5) {
                                    Text("Backdrops")
                                        .shouldUnderline(viewModel.mediaSelected)
                                    Text("\(viewModel.entityDetail.image?.backdrops.count ?? 0)")
                                        .font(.caption)
                                }
                            }
                            .buttonStyle(.plain)

                            Button {
                                viewModel.selectMediaType(.poster)
                            } label: {
                                HStack(alignment: .firstTextBaseline, spacing: 5) {
                                    Text("Posters")
                                        .shouldUnderline(!viewModel.mediaSelected)
                                    Text("\(viewModel.entityDetail.image?.posters.count ?? 0)")
                                        .font(.caption)
                                }
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.leading)
                    }
                    .listRowSeparator(.visible)
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .top, spacing: 0) {
                        ForEach(viewModel.entityDetail.displayImageLinks, id: \.self) { path in
                            AsyncImage(url: URL(string: path), transaction: Transaction(animation: .linear)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 500, height: 300)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .frame(width: viewModel.imageWidth, height: 300)
                                case .failure:
                                    Image(uiImage: UIImage(named: "NoImage")!)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: viewModel.imageWidth, height: 300)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                    }
                }
            }
            .listRowSeparator(.hidden)
            .padding(.top)
            
            VStack(alignment: .leading, spacing: 10) {
                NavigationLink(destination: EmptyView()) {
                    HStack {
                        Text("See Also")
                            .font(.headline)

                        HStack(alignment: .firstTextBaseline, spacing: 10) {
                            Button {
                                viewModel.selectSeeAlsoType(.recommend)
                            } label: {
                                HStack(alignment: .firstTextBaseline, spacing: 5) {
                                    Text("Recommend")
                                        .shouldUnderline(viewModel.seeAlsoTypeSelected)
                                    Text("\(viewModel.entityDetail.totalRecommends)")
                                        .font(.caption)
                                }
                            }
                            .buttonStyle(.plain)

                            Button {
                                viewModel.selectSeeAlsoType(.similar)
                            } label: {
                                HStack(alignment: .firstTextBaseline, spacing: 5) {
                                    Text("Similar")
                                        .shouldUnderline(!viewModel.seeAlsoTypeSelected)
                                    Text("\(viewModel.entityDetail.totalSimilars)")
                                        .font(.caption)
                                }
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.leading)
                    }
                    .listRowSeparator(.hidden)
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    EntityHStack(displayObjects: viewModel.entityDetail.displaySameObjects)
                }
            }
            .listRowSeparator(.hidden)
            .padding(.top)
        }
        .listStyle(.plain)
        .listRowSeparator(.hidden)
        .listRowSeparatorTint(.clear)
        .padding(.bottom)
        .navigationTitle(viewModel.navigationTitle)
        .task {
            try? await viewModel.fetchDetail()
        }
        .onDisappear {
            viewModel.resetSelectionWhenViewDissapear()
        }
    }
}

struct EntityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EntityDetailView(viewModel: EntityDetailViewViewModel(id: 0, navigationTitle: ""))
    }
}
