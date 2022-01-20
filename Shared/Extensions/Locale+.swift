//
//  Locale+.swift
//  My Movie App (iOS)
//
//  Created by Tuyen Le on 1/17/22.
//

import Foundation

extension Locale {
    static var currentCountryAndLanguageCode: String {
        guard let languageCode = Locale.current.languageCode, let countryCode = Locale.current.regionCode else {
            return "en-US"
        }

        return "\(languageCode)-\(countryCode)"
    }
}
