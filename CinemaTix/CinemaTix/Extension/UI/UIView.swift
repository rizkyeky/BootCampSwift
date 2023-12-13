//
//  UIView+Extension.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 18/11/22.
//

import UIKit

extension UIView {
    
    convenience init(frame: CGRect, color: UIColor) {
        self.init(frame: frame)
        backgroundColor = color
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { subView in
            self.addSubview(subView)
        }
    }
    
    func makeCornerRadius(_ radius: CGFloat, maskedCorner: CACornerMask? = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]) {
        layer.cornerRadius = radius
        layer.maskedCorners = maskedCorner ?? [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        clipsToBounds = true
    }
    
    func makeCornerRadiusRounded() {
        let heigth = self.frame.height
        layer.cornerRadius = heigth/2
        clipsToBounds = true
    }
    
    func makeBorder(width: Double = 1.0, color: UIColor = AppColor.separator) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    func makeBorder(color: UIColor = AppColor.separator) {
        layer.borderWidth = 1.0
        layer.borderColor = color.cgColor
    }
}
