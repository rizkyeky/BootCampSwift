//
//  GradientView.swift
//  CinemaTix
//
//  Created by Eky on 14/11/23.
//

import Foundation
import UIKit

class GradientView: UIView {
    
    enum Direction {
        case horizontal
        case vertical
        case horizontalReverse
        case verticalReverse
    }
    
    var direction: Direction = .vertical {
        didSet {
            changeDir()
        }
    }
    
    var startColor = UIColor.black.cgColor {
        didSet {
            setColors()
        }
    }
    var endColor = UIColor.clear.cgColor {
        didSet {
            setColors()
        }
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradient()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }
    
    private func setupGradient() {
        setColors()
        changeDir()
    }
    
    func setColors() {
        guard let gradientLayer = self.layer as? CAGradientLayer else {
            return
        }
        gradientLayer.colors = [startColor, endColor]
        gradientLayer.locations = [0.0, 1.0]
    }
    
    func changeDir() {
        guard let gradientLayer = self.layer as? CAGradientLayer else {
            return
        }
        switch direction {
        case .horizontal:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        case .horizontalReverse:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        case .vertical:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        case .verticalReverse:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        }
    }
}
