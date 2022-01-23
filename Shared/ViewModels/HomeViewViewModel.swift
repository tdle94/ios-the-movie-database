//
//  HomeViewModel.swift
//  My Movie App (iOS)
//
//  Created by Tuyen Le on 1/18/22.
//

import Foundation
import TMDBAPI
import SwiftUI

class HomeViewViewModel: ObservableObject {
    @ObservedObject var movieFetcherViewModel = MovieFetcherViewModel()
    @ObservedObject var tvShowFetcherViewModel = TVShowFetcherViewModel()

    @Published var displayObjects: [DisplayObject] = []
    @Published var displayObjects1: [DisplayObject] = []
    @Published var displayObjects2: [DisplayObject] = []
    @Published var displayObjects3: [DisplayObject] = []
    @Published var latest: DisplayObject?

    @Published var hideInitialProgressView = false
    @Published var hideError = false
    @Published var hidePresentView = true
    @Published var shouldUnderline: Bool = true
    
    @Published var text: String = "Now Playing"
    @Published var text1: String = "Upcoming"
    @Published var text2: String = "Popular"
    @Published var text3: String = "Top Rated"

    var selection: Selection?

    enum Selection {
        case movie
        case tvshow
    }

    func selected(_ selection: Selection, refresh: Bool = false, hideLoadingIndicator: Bool = false) {
        if selection == self.selection && !refresh {
            return
        }

        hidePresentView = true
        hideError = true
        hideInitialProgressView = hideLoadingIndicator

        shouldUnderline = selection == .movie
        self.selection = selection

        switch selection {
        case .movie:
            Task {
                try await movieFetcherViewModel.fetch()
                
                latest = movieFetcherViewModel.latestMovieViewModel.homeViewObjects.first
                displayObjects = movieFetcherViewModel.nowPlayingMovieViewModel.homeViewObjects
                displayObjects1 = movieFetcherViewModel.upcomingMovieViewModel.homeViewObjects
                displayObjects2 = movieFetcherViewModel.popularMovieViewModel.homeViewObjects
                displayObjects3 = movieFetcherViewModel.topRatedMovieViewModel.homeViewObjects
                
                text = "Now Playing"
                text1 = "Upcoming"

                hideInitialProgressView = movieFetcherViewModel.hideInitialProgressView
                hideError = movieFetcherViewModel.hideError
                hidePresentView = movieFetcherViewModel.hidePresentView
                
            }
        case .tvshow:
            Task {

                try await tvShowFetcherViewModel.fetch()

                latest = tvShowFetcherViewModel.latestTVShowViewModel.homeViewObjects.first
                displayObjects = tvShowFetcherViewModel.airingTodayTVShowViewModel.homeViewObjects
                displayObjects1 = tvShowFetcherViewModel.onTheAirTVShowViewModel.homeViewObjects
                displayObjects2 = tvShowFetcherViewModel.popularTVShowViewModel.homeViewObjects
                displayObjects3 = tvShowFetcherViewModel.topRatedTVShowViewModel.homeViewObjects
                
                text = "Airing Today"
                text1 = "On The Air"
                
                hideInitialProgressView = tvShowFetcherViewModel.hideInitialProgressView
                hideError = tvShowFetcherViewModel.hideError
                hidePresentView = tvShowFetcherViewModel.hidePresentView
            }
        }
    }

    func refresh() async throws {
        switch selection {
        case .movie:
            selected(.movie, refresh: true, hideLoadingIndicator: true)
        case .tvshow:
            selected(.tvshow, refresh: true, hideLoadingIndicator: true)
        case .none:
            break
        }
    }
    
    func initialFetch() async throws {
        selected(.movie)
    }
}
