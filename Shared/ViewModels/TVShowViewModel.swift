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

    @Published var homeViewObjects: [HomeViewObject] = []
    @Published var latestMovieImageURL: URL?

    func fetch() async throws {
        // Implement by subclass
    }
}

class OnTheAirTVShowViewModel: TVShowViewModel {
    override func fetch() async throws {
        let tvShowResults = try await tvShowDB.onTheAir().get().results
        homeViewObjects = tvShowResults.compactMap { HomeViewObject(title: $0.originalName, posterLink: $0.posterLink) }
    }
}

class PopularTVShowViewModel: TVShowViewModel {
    override func fetch() async throws {
        let tvShowResults = try await tvShowDB.popular().get().results
        homeViewObjects = tvShowResults.compactMap { HomeViewObject(title: $0.originalName, posterLink: $0.posterLink) }
    }
}

class TopRatedTVShowViewModel: TVShowViewModel {
    override func fetch() async throws {
        let tvShowResults = try await tvShowDB.topRated().get().results
        homeViewObjects = tvShowResults.compactMap { HomeViewObject(title: $0.originalName, posterLink: $0.posterLink) }
    }
}

class AiringTodayTVShowViewModel: TVShowViewModel {
    override func fetch() async throws {
        let tvShowResults = try await tvShowDB.airingToday().get().results
        homeViewObjects = tvShowResults.compactMap { HomeViewObject(title: $0.originalName, posterLink: "https://image.tmdb.org/t/p/w200" + ($0.posterPath ?? "")) }
    }
}

class LatestTVShowViewModel: TVShowViewModel {
    override func fetch() async throws {
        let latestTVShowResult = try await tvShowDB.latest(language: Locale.currentCountryAndLanguageCode).get()
        homeViewObjects = [HomeViewObject(title: latestTVShowResult.originalName, posterLink: "https://image.tmdb.org/t/p/w200" + (latestTVShowResult.posterPath ?? ""))]
    }
}
