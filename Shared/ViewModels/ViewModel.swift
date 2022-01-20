//
//  ViewModel.swift
//  My Movie App (iOS)
//
//  Created by Tuyen Le on 1/17/22.
//

import Foundation
import SwiftUI

class ViewModel {
    @Published var hideInitialProgressView = false
    @Published var hideError = false
    @Published var hidePresentView = true
    
    func fetch(_ asynArgs: (() async throws -> Void)...) async throws {
        defer {
            hideInitialProgressView = true
            hidePresentView = !hideError
        }

        hidePresentView = true
        hideError = true

        for arg in asynArgs {
            do {
                try await arg()
            } catch let error {
                print("wtf", error)
                hideError = false
                break
            }
        }
    }
}

class MovieFetcherViewModel: ViewModel, ObservableObject {
    @ObservedObject var nowPlayingMovieViewModel = NowPlayingMovieViewModel()
    @ObservedObject var upcomingMovieViewModel = UpcomingMovieViewModel()
    @ObservedObject var popularMovieViewModel = PopularMovieViewModel()
    @ObservedObject var topRatedMovieViewModel = TopRatedMovieViewModel()
    @ObservedObject var latestMovieViewModel = LatestMovieViewModel()

    func fetch() async throws {
        try await super.fetch(nowPlayingMovieViewModel.fetch,
                              upcomingMovieViewModel.fetch,
                              popularMovieViewModel.fetch,
                              topRatedMovieViewModel.fetch,
                              latestMovieViewModel.fetch)
    }
}

class TVShowFetcherViewModel: ViewModel, ObservableObject {
    @ObservedObject var latestTVShowViewModel = LatestTVShowViewModel()
    @ObservedObject var airingTodayTVShowViewModel = AiringTodayTVShowViewModel()
    @ObservedObject var onTheAirTVShowViewModel = OnTheAirTVShowViewModel()
    @ObservedObject var popularTVShowViewModel = PopularTVShowViewModel()
    @ObservedObject var topRatedTVShowViewModel = TopRatedTVShowViewModel()
    
    func fetch() async throws {
        try await super.fetch(latestTVShowViewModel.fetch,
                              onTheAirTVShowViewModel.fetch,
                              popularTVShowViewModel.fetch,
                              topRatedTVShowViewModel.fetch,
                              airingTodayTVShowViewModel.fetch)
    }
}
