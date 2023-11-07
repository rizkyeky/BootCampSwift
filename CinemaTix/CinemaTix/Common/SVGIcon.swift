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
    case email = "email"
    
//    func getView() -> SVGImageView? {
//        guard let url = Bundle.main.url(forResource: rawValue, withExtension: "svg") else {
//            print("\(rawValue) SVG is not found")
//            return nil
//        }
//        let svgImageView = SVGImageView.init(contentsOf: url)
//        return svgImageView
//    }
    
    func getImage() -> UIImage? {
        guard let image = UIImage(named: rawValue) else {
            print("\(rawValue) Image is not found")
            return nil
        }
        return image
    }
}
