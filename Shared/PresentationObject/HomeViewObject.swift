//
//  HomeViewObject.swift
//  My Movie App (iOS)
//
//  Created by Tuyen Le on 1/19/22.
//

import Foundation

struct HomeViewObject: Identifiable {
    var id: UUID = UUID()
    let title: String
    let posterLink: String
}
