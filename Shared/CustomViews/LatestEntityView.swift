//
//  LatestEntityView.swift
//  My Movie App (iOS)
//
//  Created by Tuyen Le on 1/12/22.
//

import SwiftUI

struct LatestEntityView: View {
    var displayObject: HomeViewObject?

    var body: some View {
        if let object = displayObject {
            AsyncImage(url: URL(string: object.posterLink), transaction: Transaction(animation: .linear)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .padding(.bottom)
                case .success(let image):
                    VStack(alignment: .leading) {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .scaledToFill()
                        Text(displayObject?.title ?? "")
                    }
                    .overlay {
                        NavigationLink(destination: EntityDetailView(viewModel: EntityDetailViewViewModel(id: object.id, navigationTitle: object.title))) {
                            EmptyView()
                        }
                        .opacity(0)
                    }
                case .failure:
                    VStack(alignment: .leading) {
                        Image(uiImage: UIImage(named: "NoImage")!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .scaledToFill()
                        Text(object.title)
                    }
                    .overlay {
                        NavigationLink(destination: EntityDetailView(viewModel: EntityDetailViewViewModel(id: object.id, navigationTitle: object.title))) {
                            EmptyView()
                        }
                        .opacity(0)
                    }
                @unknown default:
                    EmptyView()
                        .padding(.bottom)
                }
            }
        }
    }
}

struct LatestEntityView_Previews: PreviewProvider {
    static var previews: some View {
        LatestEntityView()
    }
}
