//
//  AllImageView.swift
//  My Movie App (iOS)
//
//  Created by Tuyen Le on 1/23/22.
//

import SwiftUI

struct AllImageView: View {
    let navigationTitle: String
    let imagesLink: [String]

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .center, spacing: 0) {
                ForEach(imagesLink, id: \.self) { link in
                    AsyncImage(url: URL(string: link), transaction: Transaction(animation: .linear)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: UIScreen.main.bounds.width, alignment: .center)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width, alignment: .center)
                        case .failure:
                            EmptyView()
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
            }
        }
        .navigationTitle(navigationTitle)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        AllImageView(navigationTitle: "", imagesLink: [])
    }
}
