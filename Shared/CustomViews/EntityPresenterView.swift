//
//  EntityPresenterView.swift
//  TMDB
//
//  Created by Tuyen Le on 1/9/22.
//

import SwiftUI
import TMDBAPI

struct EntityPresenterView: View {
    var displayObject: EntityTypeDisplay

    var body: some View {
        AsyncImage(url: URL(string: displayObject.posterLink), transaction: Transaction(animation: .linear)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 200, height: 300, alignment: .center)
            case .success(let image):
                NavigationLink(destination: displayObject.detailView) {
                    VStack(alignment: .leading) {
                        image
                            .resizable()
                            .frame(width: 200, height: 300)
                            .scaledToFill()
                        Text(displayObject.title)
                            .frame(width: 180, height: 45, alignment: .topLeading)
                            .lineLimit(2)
                    }
                }
                .buttonStyle(.plain)
            case .failure:
                NavigationLink(destination: displayObject.detailView) {
                    VStack(alignment: .leading) {
                        Image(uiImage: UIImage(named: "NoImage")!)
                            .resizable()
                            .frame(width: 200, height: 300)
                            .scaledToFill()
                        Text(displayObject.title)
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
        EntityPresenterView(displayObject: EntityTypeDisplay(id: -1, title: "", subtitle: "", posterLink: "", type: .movie))
    }
}
