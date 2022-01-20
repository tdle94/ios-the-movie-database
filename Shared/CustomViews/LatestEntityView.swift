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
        AsyncImage(url: URL(string: displayObject?.posterLink ?? ""), transaction: Transaction(animation: .linear)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .padding(.bottom)
            case .success(let image):
                VStack(alignment: .leading, spacing: 10) {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaledToFill()
                    Text(displayObject?.title ?? "")
                }
                .padding(.bottom)
            case .failure:
                VStack(alignment: .leading, spacing: 10) {
                    Image(uiImage: UIImage(named: "NoImage")!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaledToFill()
                    Text(displayObject?.title ?? "")
                }
                .padding(.bottom)
            @unknown default:
                EmptyView()
                    .padding(.bottom)
            }
        }
    }
}

struct LatestEntityView_Previews: PreviewProvider {
    static var previews: some View {
        LatestEntityView()
    }
}
