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
    @Published var mediaSelected: Bool = true
    @Published var entityDetail: DisplayObject = DisplayObject(id: 0, type: .movie, titleWithYear: "", title: "", backdropLink: "", posterLink: "", overview: "", tagline: "")

    var imageWidth: CGFloat {
        return mediaType == .backdrop ? 500 : 200
    }
    
    enum MediaType: String {
        case backdrop = "Backdrops"
        case poster = "Posters"
    }

    init(id: Int, navigationTitle: String) {
        self.id = id
        self.navigationTitle = navigationTitle
    }
    
    func fetchDetail() async throws {
        // Implement in subview
    }

    func selectMediaType(_ type: MediaType) {
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
}

class MovieDetailViewViewModel: EntityDetailViewViewModel {
    let movieDB = MovieDB()

    override func fetchDetail() async throws {
        do {
            let detailResponse = try await movieDB.detail(id: id).get()
            let imageResponse = try await movieDB.images(id: id, language: "").get()
            entityDetail = detailResponse.displayObject
            entityDetail.image = imageResponse
            entityDetail.displayImageLinks = imageResponse.backdropLinks.getPrefix(5)
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
            entityDetail = detailResponse.displayObject
            entityDetail.image = imageResponse
            entityDetail.displayImageLinks = imageResponse.backdropLinks.getPrefix(5)
        } catch let error {
            print(error)
        }
    }
}
