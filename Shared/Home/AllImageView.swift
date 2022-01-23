//
//  AllImageView.swift
//  My Movie App (iOS)
//
//  Created by Tuyen Le on 1/23/22.
//

import SwiftUI

struct AllImageView: View {
    let navigationTitle: String

    var body: some View {
        ScrollView {
            
        }
        .navigationTitle(navigationTitle)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        AllImageView(navigationTitle: "")
    }
}
