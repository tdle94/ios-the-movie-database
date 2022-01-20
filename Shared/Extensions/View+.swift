//
//  View+.swift
//  My Movie App (iOS)
//
//  Created by Tuyen Le on 1/16/22.
//

import SwiftUI

extension View {
    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
            self.hidden()
        } else {
            self
        }
    }
}

extension Text {
    @ViewBuilder func shouldUnderline(_ underline: Bool) -> some View {
        if underline {
            self
                .underline()
                .bold()
        } else {
            self
        }
    }
}
