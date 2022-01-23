//
//  EntityPresenterView.swift
//  TMDB
//
//  Created by Tuyen Le on 1/9/22.
//

import SwiftUI

struct EntityPresenterView: View {
    var displayObject: HomeViewObject

    var body: some View {
        AsyncImage(url: URL(string: displayObject.posterLink), transaction: Transaction(animation: .linear)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 200, height: 300, alignment: .center)
            case .success(let image):
                NavigationLink(destination: EntityDetailView(viewModel: EntityDetailViewViewModel(id: displayObject.id, navigationTitle: displayObject.title))) {
                    VStack(alignment: .leading) {
                        image
                            .scaledToFill()
                        Text(displayObject.title)
                            .frame(width: 180, height: 45, alignment: .topLeading)
                            .lineLimit(2)
                    }
                }
                .buttonStyle(.plain)
            case .failure:
                NavigationLink(destination: EntityDetailView(viewModel: EntityDetailViewViewModel(id: displayObject.id, navigationTitle: displayObject.title))) {
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
        EntityPresenterView(displayObject: HomeViewObject(id: 0, title: "", posterLink: ""))
    }
}
