//
//  Icon.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import Foundation
import UIKit

enum SFIcon {
    static let home = UIImage(systemName: "house.fill")
    static let system = UIImage(systemName: "gear")
    static let add = UIImage(systemName: "plus")
    static let filter = UIImage(systemName: "line.3.horizontal.decrease")
    
    static let forward = UIImage(systemName: "chevron.right")
    static let back = UIImage(systemName: "chevron.left")
    static let backBlue = {
        let originalImage = UIImage(systemName: "chevron.left")
        let tintedImage = originalImage?.withRenderingMode(.alwaysTemplate)
        let coloredImage = tintedImage?.withTintColor(UIColor.blue)
        return coloredImage
    }()
    
    static let search = UIImage(systemName: "magnifyingglass")
    static let setting = UIImage(systemName: "gear")
    static let profile = UIImage(systemName: "person")
    
    static let up = UIImage(systemName: "square.and.arrow.up")
    static let down = UIImage(systemName: "square.and.arrow.down")
    
    static let close = UIImage(systemName: "xmark")
    
//    static let search = UIImage(from: .fontAwesome5, code: "search", textColor: .tintColor, backgroundColor: .clear, size: CGSize(width: 40, height: 40))
//    
//    static let setting = UIImage(from: .fontAwesome5, code: "gear", textColor: .tintColor, backgroundColor: .clear, size: CGSize(width: 40, height: 40))
//    
//    static let profile = UIImage(from: .fontAwesome5, code: "user", textColor: .tintColor, backgroundColor: .clear, size: CGSize(width: 40, height: 40))
}
