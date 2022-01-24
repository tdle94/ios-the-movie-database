//
//  DisplayObject+.swift
//  My Movie App (iOS)
//
//  Created by Tuyen Le on 1/23/22.
//

import Foundation
import TMDBAPI

extension DisplayObject {
    @MainActor
    var detailViewViewModel: EntityDetailView {
        return type == .movie
        ? EntityDetailView(viewModel: MovieDetailViewViewModel(id: id, navigationTitle: title))
        : EntityDetailView(viewModel: TVShowDetailViewViewModel(id: id, navigationTitle: title))
    }
}
