//
//  ViewAllView.swift
//  My Movie App (iOS)
//
//  Created by Tuyen Le on 1/18/22.
//

import SwiftUI

struct SeeAllView: View {
    let navigationTitle: String

    var body: some View {
        NavigationView {
            
        }
        .navigationTitle(navigationTitle)
    }
}

struct SeeAllView_Previews: PreviewProvider {
    static var previews: some View {
        SeeAllView(navigationTitle: "hello")
    }
}
