//
//  Array+.swift
//  My Movie App (iOS)
//
//  Created by Tuyen Le on 1/23/22.
//

import Foundation

extension Array {
    func getPrefix(_ maxLength: Int) -> [Element] {
        return Array(self.prefix(maxLength))
    }
}
