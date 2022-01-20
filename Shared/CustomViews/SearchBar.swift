//
//  SearchBar.swift
//  My Movie App (iOS)
//
//  Created by Tuyen Le on 1/18/22.
//

import SwiftUI

struct SearchBar: View {
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 10) {
            Image(systemName: "magnifyingglass")
            TextField("Search", text: $searchText, prompt: Text("Search"))
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}
