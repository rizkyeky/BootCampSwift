//
//  Localization.swift
//  CinemaTix
//
//  Created by Eky on 04/12/23.
//

import Foundation

class LanguageManager {
    static let shared = LanguageManager()
    
    private init() {}
    
    var currentLanguage: String {
        get {
            return UserDefaults.standard.string(forKey: "appLanguage") ?? "en"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "appLanguage")
            NotificationCenter.default.post(name: .appLanguageChanged, object: nil)
        }
    }
}

extension Notification.Name {
    static let appLanguageChanged = Notification.Name("AppLanguageChanged")
}

enum LanguageStrings: String {
    case signIn
    case home
    case wallet
    case profile
    case playingNow
    case upcoming
    case recommendedForYou
    case topRated
    
    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "")
    }
}
