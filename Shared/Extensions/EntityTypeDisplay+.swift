//
//  DisplayObject+.swift
//  My Movie App (iOS)
//
//  Created by Tuyen Le on 1/23/22.
//

import Foundation
import TMDBAPI
import SwiftUI

extension EntityTypeDisplay {
    @MainActor
    var detailView: EntityDetailView {
        if type == .movie {
            return EntityDetailView(viewModel: MovieDetailViewViewModel(id: id, navigationTitle: title))
        } else if type == .tvshow {
            return EntityDetailView(viewModel: TVShowDetailViewViewModel(id: id, navigationTitle: title))
        }
        return EntityDetailView(viewModel: PeopleDetailViewViewModel(id: id, navigationTitle: title))
    }
}
