//
//  MovieViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 1/11/22.
//

import Foundation
import TMDBAPI
import SwiftUI

@MainActor
class MovieViewModel: ObservableObject {
    @Published var homeViewObjects: [HomeViewObject] = []

    let movieDB = MovieDB()
    
    func fetch() async throws {
        // Implement by subclass
    }
}

class PopularMovieViewModel: MovieViewModel {
    override func fetch() async throws {
        let movieResults = try await movieDB.popular().get().results
        homeViewObjects = movieResults.compactMap { HomeViewObject(id: $0.id, title: $0.originalTitle, posterLink: $0.posterLink) }
    }
}

class NowPlayingMovieViewModel: MovieViewModel {
    override func fetch() async throws {
        let movieResults = try await movieDB.nowPlaying().get().results
        homeViewObjects = movieResults.compactMap { HomeViewObject(id: $0.id, title: $0.originalTitle, posterLink: $0.posterLink) }
    }
}

class UpcomingMovieViewModel: MovieViewModel {
    override func fetch() async throws {
        let movieResults = try await movieDB.upcoming().get().results
        homeViewObjects = movieResults.compactMap { HomeViewObject(id: $0.id, title: $0.originalTitle, posterLink: $0.posterLink) }
    }
}

class TopRatedMovieViewModel: MovieViewModel {
    override func fetch() async throws {
        let movieResults = try await movieDB.topRated().get().results
        homeViewObjects = movieResults.compactMap { HomeViewObject(id: $0.id, title: $0.originalTitle, posterLink: $0.posterLink) }
    }
}

class LatestMovieViewModel: MovieViewModel {
    override func fetch() async throws {
        let latestMovie = try await movieDB.latest(language: Locale.currentCountryAndLanguageCode).get()
        
        var posterPath = latestMovie.posterPath ?? latestMovie.backdropPath

        if posterPath == nil {
            let images = try await movieDB.images(id: latestMovie.id).get()
            posterPath = images.posters.first?.filePath ?? images.backdrops.first?.filePath
        }
        
        homeViewObjects = [HomeViewObject(id: latestMovie.id,title: latestMovie.originalTitle, posterLink: "https://image.tmdb.org/t/p/original/" + (posterPath ?? ""))]
    }
}
