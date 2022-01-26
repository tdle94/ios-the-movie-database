//
//  EntityDetailViewViewModel.swift
//  My Movie App (iOS)
//
//  Created by Tuyen Le on 1/22/22.
//

import Foundation
import TMDBAPI
import SwiftUI

@MainActor
class EntityDetailViewViewModel: ObservableObject {
    let id: Int
    let navigationTitle: String
    var mediaType: MediaType = .backdrop
    var seeAlsoType: SeeAlsoType = .recommend
    @Published var mediaSelected: Bool = true
    @Published var seeAlsoTypeSelected: Bool = true
    @Published var entityDetail: DisplayObject = DisplayObject(id: 0, type: .movie, titleWithYear: "", title: "", backdropLink: "", posterLink: "", overview: "", tagline: "")

    var imageWidth: CGFloat {
        return mediaType == .backdrop ? 500 : 200
    }

    var allDisplayImageLinks: [String] {
        return mediaType == .backdrop ? (entityDetail.image?.backdropLinks ?? []) : (entityDetail.image?.posterLinks ?? [])
    }

    enum MediaType: String {
        case backdrop = "Backdrops"
        case poster = "Posters"
    }
    
    enum SeeAlsoType: String {
        case similar = "Similars"
        case recommend = "Recommends"
    }

    init(id: Int, navigationTitle: String) {
        self.id = id
        self.navigationTitle = navigationTitle
    }
    
    func fetchDetail() async throws {
        // Implement in subview
    }

    func selectMediaType(_ type: MediaType) {
        guard type != mediaType else { return }

        mediaSelected.toggle()
        switch type {
        case .backdrop:
            entityDetail.displayImageLinks = entityDetail.image?.backdropLinks.getPrefix(5) ?? []
            mediaType = .backdrop
        case .poster:
            entityDetail.displayImageLinks = entityDetail.image?.posterLinks.getPrefix(5) ?? []
            mediaType = .poster
        }
    }

    func selectSeeAlsoType(_ type: SeeAlsoType) {
        guard seeAlsoType != type else { return }

        seeAlsoTypeSelected.toggle()

        switch type {
        case .recommend:
            entityDetail.displaySameObjects = entityDetail.recommends
            seeAlsoType = .recommend
        case .similar:
            entityDetail.displaySameObjects = entityDetail.similars
            seeAlsoType = .similar
        }
    }

    func resetSelection() {
        mediaSelected = true
        mediaType = .backdrop
        seeAlsoTypeSelected = true
        seeAlsoType = .recommend
    }
}

class MovieDetailViewViewModel: EntityDetailViewViewModel {
    let movieDB = MovieDB()

    override func fetchDetail() async throws {
        do {
            let detailResponse = try await movieDB.detail(id: id).get()
            let imageResponse = try await movieDB.images(id: id, language: "").get()
            let recommendMovieResponse = try await movieDB.recommendations(id: id).get()
            let similarMovieResponse = try await movieDB.similars(id: id).get()

            entityDetail = detailResponse.displayObject
            entityDetail.image = imageResponse
            entityDetail.displayImageLinks = imageResponse.backdropLinks.getPrefix(5)
            entityDetail.recommends = recommendMovieResponse.displayObjects
            entityDetail.similars = similarMovieResponse.displayObjects
            entityDetail.totalRecommends = recommendMovieResponse.totalResults
            entityDetail.totalSimilars = similarMovieResponse.totalResults
            entityDetail.displaySameObjects = recommendMovieResponse.displayObjects
        } catch let error {
            print(error)
        }
    }

}

class TVShowDetailViewViewModel: EntityDetailViewViewModel {
    let tvshowDB = TVShowDB()
    
    override func fetchDetail() async throws {
        do {
            let detailResponse = try await tvshowDB.detail(id: id).get()
            let imageResponse = try await tvshowDB.images(id: id, language: "").get()
            let recommendTVShowResponse = try await tvshowDB.recommendations(id: id).get()
            let similarTVShowResponse = try await tvshowDB.similar(id: id).get()

            entityDetail = detailResponse.displayObject
            entityDetail.image = imageResponse
            entityDetail.displayImageLinks = imageResponse.backdropLinks.getPrefix(5)

            entityDetail = detailResponse.displayObject
            entityDetail.image = imageResponse
            entityDetail.displayImageLinks = imageResponse.backdropLinks.getPrefix(5)
            entityDetail.recommends = recommendTVShowResponse.displayObjects
            entityDetail.similars = similarTVShowResponse.displayObjects
            entityDetail.totalRecommends = recommendTVShowResponse.totalResults
            entityDetail.totalSimilars = similarTVShowResponse.totalResults
            entityDetail.displaySameObjects = recommendTVShowResponse.displayObjects
        } catch let error {
            print(error)
        }
    }
}
