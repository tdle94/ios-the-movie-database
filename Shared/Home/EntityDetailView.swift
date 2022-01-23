//
//  EntityDetailView.swift
//  My Movie App (iOS)
//
//  Created by Tuyen Le on 1/20/22.
//

import SwiftUI

struct EntityDetailView: View {
    var viewModel: EntityDetailViewViewModel

    var body: some View {
        NavigationView {
            
        }
        .navigationTitle(viewModel.navigationTitle)
    }
}

struct EntityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EntityDetailView(viewModel: EntityDetailViewViewModel(id: 0, navigationTitle: ""))
    }
}
