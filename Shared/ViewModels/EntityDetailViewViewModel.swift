//
//  EntityDetailViewViewModel.swift
//  My Movie App (iOS)
//
//  Created by Tuyen Le on 1/22/22.
//

import Foundation
import TMDBAPI

@MainActor
class EntityDetailViewViewModel: ObservableObject {
    let id: Int
    let navigationTitle: String
    let movieDB = MovieDB()
    var mediaType: MediaType = .backdrop
    @Published var mediaSelected: Bool = true
    @Published var entityDetail: DisplayObject = DisplayObject(id: 0, titleWithYear: "", backdropLink: "", posterLink: "", overview: "", tagline: "")
    
    enum MediaType: String {
        case backdrop = "Backdrops"
        case poster = "Posters"
    }

    init(id: Int, navigationTitle: String) {
        self.id = id
        self.navigationTitle = navigationTitle
    }
    
    func fetchDetail() async throws {
        do {
            let detailResponse = try await movieDB.detail(id: id).get()
            let imageResponse = try await movieDB.images(id: id, language: "").get()
            entityDetail = detailResponse.displayObject
            entityDetail.image = imageResponse
            entityDetail.displayImageLinks = Array(imageResponse.backdropLinks.prefix(5))
        } catch let error {
            print(error)
        }
    }

    func selectMediaType(_ type: MediaType) {
        mediaSelected.toggle()
        switch type {
        case .backdrop:
            entityDetail.displayImageLinks = Array(entityDetail.image?.backdropLinks.prefix(5) ?? [])
            mediaType = .backdrop
        case .poster:
            entityDetail.displayImageLinks = Array(entityDetail.image?.posterLinks.prefix(5) ?? [])
            mediaType = .poster
        }
    }
}
