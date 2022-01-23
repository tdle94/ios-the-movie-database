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
        }
        .listStyle(.plain)
        .listRowSeparator(.hidden)
        .listRowSeparatorTint(.clear)
        .navigationTitle(viewModel.navigationTitle)
        .task {
            try? await viewModel.fetchDetail()
        }
    }
}

struct EntityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EntityDetailView(viewModel: EntityDetailViewViewModel(id: 0, navigationTitle: ""))
    }
}
