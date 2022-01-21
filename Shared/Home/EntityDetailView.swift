//
//  EntityDetailView.swift
//  My Movie App (iOS)
//
//  Created by Tuyen Le on 1/20/22.
//

import SwiftUI

struct EntityDetailView: View {
    let navigationTitle: String

    var body: some View {
        NavigationView {
            
        }
        .navigationTitle(navigationTitle)
    }
}

struct EntityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EntityDetailView(navigationTitle: "")
    }
}
