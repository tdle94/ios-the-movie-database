//
//  TVShowViewModel.swift
//  My Movie App (iOS)
//
//  Created by Tuyen Le on 1/17/22.
//

import Foundation
import TMDBAPI
import SwiftUI

@MainActor
class TVShowViewModel: ObservableObject {
    let tvShowDB = TVShowDB()

    @Published var homeViewObjects: [EntityTypeDisplay] = []
    @Published var latestMovieImageURL: URL?

    func fetch() async throws {
        // Implement by subclass
    }
}

class OnTheAirTVShowViewModel: TVShowViewModel {
    override func fetch() async throws {
        let tvShowResults = try await tvShowDB.onTheAir().get()
        homeViewObjects = tvShowResults.displayObjects
    }
}

class PopularTVShowViewModel: TVShowViewModel {
    override func fetch() async throws {
        let tvShowResults = try await tvShowDB.popular().get()
        homeViewObjects = tvShowResults.displayObjects
    }
}

class TopRatedTVShowViewModel: TVShowViewModel {
    override func fetch() async throws {
        let tvShowResults = try await tvShowDB.topRated().get()
        homeViewObjects = tvShowResults.displayObjects
    }
}

class AiringTodayTVShowViewModel: TVShowViewModel {
    override func fetch() async throws {
        let tvShowResults = try await tvShowDB.airingToday().get()
        homeViewObjects = tvShowResults.displayObjects
    }
}

class LatestTVShowViewModel: TVShowViewModel {
    override func fetch() async throws {
        let latestTVShowResult = try await tvShowDB.latest().get()
        homeViewObjects = [EntityTypeDisplay(id: latestTVShowResult.id, title: latestTVShowResult.name, subtitle: latestTVShowResult.overview, posterLink: latestTVShowResult.posterLink, type: .tvshow)]
    }
}
