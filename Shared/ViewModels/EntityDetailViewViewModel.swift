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
    @Published var creditTypeSelected: Bool = true
    @Published var mediaSelected: Bool = true
    @Published var seeAlsoTypeSelected: Bool = true
    @Published var entityDetail: DisplayObject = DisplayObject(id: 0, type: .movie, titleWithYear: "", title: "", backdropLink: "", posterLink: "", overview: "", tagline: "")

    var imageWidth: CGFloat {
        return mediaType == .backdrop ? 500 : 200
    }

    var allDisplayImageLinks: [String] {
        return mediaType == .backdrop ? entityDetail.images.backdropLinks: entityDetail.images.posterLinks
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
            entityDetail.displayImageLinks = entityDetail.images.backdropLinks.getPrefix(5)
            mediaType = .backdrop
        case .poster:
            entityDetail.displayImageLinks = entityDetail.images.posterLinks.getPrefix(5)
            mediaType = .poster
        }
    }

    func selectSeeAlsoType(_ type: SeeAlsoType) {
        guard seeAlsoType != type else { return }

        seeAlsoTypeSelected.toggle()

        switch type {
        case .recommend:
            entityDetail.displaySameObjects = entityDetail.recommendations
            seeAlsoType = .recommend
        case .similar:
            entityDetail.displaySameObjects = entityDetail.similar
            seeAlsoType = .similar
        }
    }

    func selectCreditType(_ type: Credit.DisplayType) {
        creditTypeSelected.toggle()
        entityDetail.credits.displayType = type
    }

    func resetSelection() {
        mediaSelected = true
        mediaType = .backdrop
        seeAlsoTypeSelected = true
        seeAlsoType = .recommend
        creditTypeSelected = true
        entityDetail.credits.displayType = .cast
    }
}

class MovieDetailViewViewModel: EntityDetailViewViewModel {
    let movieDB = MovieDB()

    override func fetchDetail() async throws {
        do {
            let detailResponse = try await movieDB.detail(id: id).get()
            entityDetail = detailResponse.displayObject
            print(detailResponse.images.backdrops.count)
        } catch let error {
            print(error)
        }
    }
}

class TVShowDetailViewViewModel: EntityDetailViewViewModel {
    let tvshowDB = TVShowDB()
    
    override func fetchDetail() async throws {
        do {
            let detailResponse = try await tvshowDB.detail(id: id, language: "").get()
            entityDetail = detailResponse.displayObject
            print(detailResponse.similar)
        } catch let error {
            print(error)
        }
    }
}

class PeopleDetailViewViewModel: EntityDetailViewViewModel {
    
}
