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
    case email = "mail"
    case faceId = "faceid"
    
    case bag = "bag-check"
    case bagOutline = "bag-check-outline"
    case home = "home"
    case homeOutline = "home-outline"
    case wallet = "wallet"
    case walletOutline = "wallet-outline"
    case person = "person"
    case personOutline = "person-outline"
    
    func getImage() -> UIImage? {
        guard let image = UIImage(named: rawValue) else {
            print("\(rawValue) Image is not found")
            return nil
        }
        return image
    }
}
