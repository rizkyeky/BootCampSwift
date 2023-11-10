//
//  Card.swift
//  CinemaTix
//
//  Created by Eky on 08/11/23.
//

import UIKit

class Card: UIView {
    
    private var tapGesture = UITapGestureRecognizer()
    
    public var onTap: (() -> Void)?
    
    public var radius: CGFloat = 16 {
        didSet {
            self.layer.cornerRadius = radius
        }
    }
    
    public var backgroundView = UIImageView() {
        didSet {
            setupBackground()
        }
    }
    
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
    
    private func setupTapGesture() {
        self.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self
        tapGesture.cancelsTouchesInView = false
    }
    
    private func setupBackground() {
        
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        setupBackgroundView()
    }
    
    private func setupBackgroundView() {
//        if backgroundView.image == nil {
//            backgroundView.image = UIImage(named: "imagenotfound")
//        }
        self.addSubview(backgroundView)
        backgroundView.isUserInteractionEnabled = true
        backgroundView.layer.cornerRadius = self.layer.cornerRadius
        backgroundView.clipsToBounds = true
        backgroundView.contentMode = .scaleAspectFill
        backgroundView.frame.origin = bounds.origin
        backgroundView.frame.size = CGSize(width: bounds.width, height: bounds.height)
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
    
    internal override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetAnimated()
        onTap?()
    }
    
    internal override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetAnimated()
    }
    
    internal override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        shrinkAnimated()
    }
}
