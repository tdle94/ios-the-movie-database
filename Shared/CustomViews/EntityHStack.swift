//
//  MovieHStack.swift
//  TMDB
//
//  Created by Tuyen Le on 1/9/22.
//

import SwiftUI
import TMDBAPI

struct EntityHStack: View {
    var displayObjects: [DisplayObject]

    var body: some View {
        LazyHStack {
            ForEach(displayObjects) { item in
                EntityPresenterView(displayObject: item)
            }
        }
    }
}

struct MovieHStack_Previews: PreviewProvider {
    static var previews: some View {
        EntityHStack(displayObjects: [])
    }
}
