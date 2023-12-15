//
//  UIImageView.swift
//  CinemaTix
//
//  Created by Eky on 14/12/23.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func loadFromUrl(url: URL?, placeholder: UIImage? = nil) {
        self.kf.indicatorType = .custom(indicator: ImageActivityIndicator())
//        self.kf.indicatorType = .activity
        self.kf.setImage(with: url,
            placeholder: placeholder,
            options: [
                .processor(compressImage()),
                .transition(.fade(0.48)),
            ]
        )
    }
    
    private func compressImage(_ percentage: CGFloat = 0.9) -> DownsamplingImageProcessor {
        return DownsamplingImageProcessor(size: CGSize(width: bounds.size.width*percentage, height: bounds.size.height*percentage))
    }
}
