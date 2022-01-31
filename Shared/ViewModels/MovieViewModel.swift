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
    @Published var homeViewObjects: [EntityTypeDisplay] = []

    let movieDB = MovieDB()
    
    func fetch() async throws {
        // Implement by subclass
    }
}

class PopularMovieViewModel: MovieViewModel {
    override func fetch() async throws {
        let movieResults = try await movieDB.popular().get()
        homeViewObjects = movieResults.displayObjects
    }
}

class NowPlayingMovieViewModel: MovieViewModel {
    override func fetch() async throws {
        let movieResults = try await movieDB.nowPlaying().get()
        homeViewObjects = movieResults.displayObjects
    }
}

class UpcomingMovieViewModel: MovieViewModel {
    override func fetch() async throws {
        let movieResults = try await movieDB.upcoming().get()
        homeViewObjects = movieResults.displayObjects
    }
}

class TopRatedMovieViewModel: MovieViewModel {
    override func fetch() async throws {
        let movieResults = try await movieDB.topRated().get()
        homeViewObjects = movieResults.displayObjects
    }
}

class LatestMovieViewModel: MovieViewModel {
    override func fetch() async throws {
        let latestMovie = try await movieDB.latest().get()
        
        homeViewObjects = [EntityTypeDisplay(id: latestMovie.id, title: latestMovie.title, subtitle: latestMovie.overview, posterLink: latestMovie.posterLink, type: .movie)]
    }
}
