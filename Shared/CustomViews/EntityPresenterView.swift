//
//  EntityPresenterView.swift
//  TMDB
//
//  Created by Tuyen Le on 1/9/22.
//

import SwiftUI

struct EntityPresenterView: View {
    let title: String
    let url: String

    var body: some View {
        AsyncImage(url: URL(string: url), transaction: Transaction(animation: .linear)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 200, height: 300, alignment: .center)
            case .success(let image):
                NavigationLink(destination: EntityDetailView(navigationTitle: title)) {
                    VStack(alignment: .leading) {
                        image
                            .scaledToFill()
                        Text(title)
                            .frame(width: 180, height: 45, alignment: .topLeading)
                            .lineLimit(2)
                    }
                }
                .buttonStyle(.plain)
            case .failure:
                NavigationLink(destination: EntityDetailView(navigationTitle: title)) {
                    VStack(alignment: .leading) {
                        Image(uiImage: UIImage(named: "NoImage")!)
                            .resizable()
                            .frame(width: 200, height: 300)
                            .scaledToFill()
                        Text(title)
                            .frame(width: 180, height: 45, alignment: .topLeading)
                            .lineLimit(2)
                    }
                }
                .buttonStyle(.plain)
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct EntityPresenterView_Previews: PreviewProvider {
    static var previews: some View {
        EntityPresenterView(title: "Santana", url: "https://image.tmdb.org/t/p/w200/9Rj8l6gElLpRL7Kj17iZhrT5Zuw.jpg")
    }
}
