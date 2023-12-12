//
//  Loading.swift
//  CinemaTix
//
//  Created by Eky on 21/11/23.
//

import Foundation
import UIKit
import PKHUD

class Loading {
    let activityIndicator = UIActivityIndicatorView(style: .large)
    func show() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.frame = .init(x: 0, y: 0, width: 60, height: 60)
        activityIndicator.startAnimating()
        activityIndicator.color = .systemBackground
        PKHUD.sharedHUD.contentView = activityIndicator
        PKHUD.sharedHUD.show()
    }
    
    func hide() {
        activityIndicator.stopAnimating()
        PKHUD.sharedHUD.hide(true)
    }
}
