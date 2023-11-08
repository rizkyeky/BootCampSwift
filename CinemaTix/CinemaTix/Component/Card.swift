//
//  Card.swift
//  CinemaTix
//
//  Created by Eky on 08/11/23.
//

import UIKit

class Card: UIView {
    
    private let backgroundIV = UIImageView()
    private var tap = UITapGestureRecognizer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupTapGesture()
        setupBackground()
    }
    
    private func setupView() {
        let view = self.loadNib()
        view.frame = self.bounds
        view.clipsToBounds = true
        self.addSubview(view)
    }
    
    func setupTapGesture() {
        self.addGestureRecognizer(tap)
        tap.delegate = self
        tap.cancelsTouchesInView = false
    }
    
    func setupBackground() {
        self.addSubview(backgroundIV)
        backgroundIV.isUserInteractionEnabled = true
        self.clipsToBounds = true
    }
    
    @IBInspectable public var backgroundImage: UIImage? {
        didSet {
            self.backgroundIV.image = backgroundImage
        }
    }
    
    @IBInspectable public var radius: CGFloat = 16 {
        didSet {
            self.layer.cornerRadius = radius
        }
    }
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.layer.cornerRadius = radius
        
        backgroundIV.image = backgroundImage
        backgroundIV.layer.cornerRadius = self.layer.cornerRadius
        backgroundIV.clipsToBounds = true
        backgroundIV.contentMode = .scaleAspectFill
        backgroundIV.frame.origin = bounds.origin
        backgroundIV.frame.size = CGSize(width: bounds.width, height: bounds.height)
    }
}


extension Card: UIGestureRecognizerDelegate {
    
    private func shrinkAnimated() {
        UIView.animate(withDuration: 0.096, delay: 0.0, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
        })
    }
    
    private func resetAnimated() {
        UIView.animate(withDuration: 0.096, delay: 0.0, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform.identity
        })
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetAnimated()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetAnimated()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        shrinkAnimated()
    }
}
