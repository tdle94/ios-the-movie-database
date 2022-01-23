//
//  EntityDetailViewViewModel.swift
//  My Movie App (iOS)
//
//  Created by Tuyen Le on 1/22/22.
//

import Foundation

class EntityDetailViewViewModel: ObservableObject {
    let id: Int
    let navigationTitle: String

    init(id: Int, navigationTitle: String) {
        self.id = id
        self.navigationTitle = navigationTitle
    }
}
