//
// PendingStateView.swift
//  My Movie App (iOS)
//
//  Created by Tuyen Le on 1/16/22.
//

import SwiftUI

struct PendingStateView: View {
    var hideInitialProgressView: Bool
    var hideError: Bool
    var action: (() async throws -> Void)?

    var body: some View {
        ProgressView("Loading...")
            .isHidden(hideInitialProgressView)
        VStack(alignment: .center, spacing: 10) {
            Text("Something Went Wrong")
            Button("Try Again") {
                Task {
                    try? await action?()
                }
            }
        }
        .isHidden(hideError)
    }
}

struct PendingStateView_Previews: PreviewProvider {
    static var previews: some View {
        PendingStateView(hideInitialProgressView: true, hideError: true)
    }
}
