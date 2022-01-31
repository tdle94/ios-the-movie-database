//
//  LatestEntityView.swift
//  My Movie App (iOS)
//
//  Created by Tuyen Le on 1/12/22.
//

import SwiftUI
import TMDBAPI

struct LatestEntityView: View {
    var displayObject: EntityTypeDisplay

    var body: some View {
        AsyncImage(url: URL(string: displayObject.posterLink), transaction: Transaction(animation: .linear)) { phase in
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
                    Text(displayObject.title)
                }
                .overlay {
                    NavigationLink(destination: displayObject.detailView) {
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
                    Text(displayObject.title)
                }
                .overlay {
                    NavigationLink(destination: displayObject.detailView) {
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

struct LatestEntityView_Previews: PreviewProvider {
    static var previews: some View {
        LatestEntityView(displayObject: EntityTypeDisplay(id: -1, title: "", subtitle: "", posterLink: "", type: .movie))
    }
}
