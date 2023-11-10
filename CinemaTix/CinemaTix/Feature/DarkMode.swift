//
//  DarkMode.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import Foundation
import UIKit

class DarkMode {
    
    private var _isActive: Bool = false
    
    var isActive: Bool {
        get {
            return _isActive
        }
    }
    
    private let defaults = UserDefaults.standard
    
    func setup(completion: (Bool) -> Void) {
        _isActive = defaults.bool(forKey: "dark_mode")
        completion(_isActive)
    }
    
    func toggle(completion: (Bool) -> Void) {
        turnOnOffUIStyle()
        _isActive.toggle()
        defaults.set(_isActive, forKey: "dark_mode")
        completion(_isActive)
    }
    
    private func turnOnOffUIStyle() {
        if #available(iOS 13.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                let windows = windowScene.windows
                for window in windows {
                    if (!_isActive) {
                        window.overrideUserInterfaceStyle = .dark
                    } else {
                        window.overrideUserInterfaceStyle = .light
                    }
                }
            }
        }
    }
}
