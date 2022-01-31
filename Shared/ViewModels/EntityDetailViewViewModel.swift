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
    @Published var creditTypeSelected: Bool = true
    @Published var mediaSelected: Bool = true
    @Published var seeAlsoTypeSelected: Bool = true
    @Published var entityDetail: DisplayDetail = DisplayDetail(id: -1,
                                                               title: "",
                                                               overview: "",
                                                               tagline: "",
                                                               backdropLink: "",
                                                               posterLink: "",
                                                               releaseDate: "",
                                                               credits: .init(),
                                                               images: .init())

    var imageWidth: CGFloat {
        return entityDetail.imageSelection == .backdrops ? 500 : 200
    }

    init(id: Int, navigationTitle: String) {
        self.id = id
        self.navigationTitle = navigationTitle
    }
    
    func fetchDetail() async throws {
        // Implement in subview
    }

    func selectMediaType(_ type: ImageSelectionType) {
        guard entityDetail.imageSelection != type else { return }
        mediaSelected.toggle()
        entityDetail.imageSelection = type
    }

    func selectSeeAlsoType(_ type: EntitySelectionType) {
        guard entityDetail.entitySelection != type else { return }
        seeAlsoTypeSelected.toggle()
        entityDetail.entitySelection = type
    }

    func selectCreditType(_ type: Credit.DisplayType) {
        creditTypeSelected.toggle()
        entityDetail.credits.displayType = type
    }

    func resetSelection() {
        mediaSelected = true
        entityDetail.imageSelection = .backdrops
        seeAlsoTypeSelected = true
        entityDetail.entitySelection = .recommendation
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
        } catch let error {
            print(error)
        }
    }
}

class PeopleDetailViewViewModel: EntityDetailViewViewModel {
    
}
