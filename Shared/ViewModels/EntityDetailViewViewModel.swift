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
    @Published var entityDetail: DisplayObject = DisplayObject(id: 0, titleWithYear: "", backdropLink: "", posterLink: "", overview: "", tagline: "")

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
        } catch let error {
            print(error)
        }
    }
}
