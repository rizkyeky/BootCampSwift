//
//  UIStackView.swift
//  CinemaTix
//
//  Created by Eky on 12/12/23.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat = 0) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
    }
    
}
