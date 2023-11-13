//
//  SVGIcon.swift
//  CinemaTix
//
//  Created by Eky on 07/11/23.
//

import Foundation
import UIKit

enum SVGIcon: String {
    
    case apple = "logo-apple"
    case google = "logo-google"
    case bag = "bag-check"
    case bagOutline = "bag-check-outline"
    case home = "home"
    case homeOutline = "home-outline"
    case wallet = "wallet"
    case walletOutline = "wallet-outline"
    case email = "mail"
    
    func getImage() -> UIImage? {
        guard let image = UIImage(named: rawValue) else {
            print("\(rawValue) Image is not found")
            return nil
        }
        return image
    }
}
