//
//  MovieHStack.swift
//  TMDB
//
//  Created by Tuyen Le on 1/9/22.
//

import SwiftUI

struct EntityHStack: View {
    var displayObjects: [HomeViewObject]

    var body: some View {
        LazyHGrid(rows: [GridItem(.fixed(100))], alignment: .top) {
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
