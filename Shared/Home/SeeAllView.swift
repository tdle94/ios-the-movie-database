//
//  ViewAllView.swift
//  My Movie App (iOS)
//
//  Created by Tuyen Le on 1/18/22.
//

import SwiftUI

struct SeeAllView: View {
    let text: String

    var body: some View {
        Text(text)
    }
}

struct SeeAllView_Previews: PreviewProvider {
    static var previews: some View {
        SeeAllView(text: "hello")
    }
}
