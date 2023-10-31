//
//  LottieLoadingView.swift
//  TimeAndClock
//
//  Created by Eky on 31/10/23.
//

import UIKit
import Lottie

@IBDesignable
class LottieLoadingView: UIView {
    
    @IBOutlet var animationView: LottieAnimationView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
        configure()
    }
    
    private func configureView() {
        let view = self.loadNib()
        view.frame = self.bounds
        view.backgroundColor = .clear
        self.addSubview(view)
    }
    
    func configure() {
        animationView = LottieAnimationView(name: "animation_loading")
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = .loop
        addSubview(animationView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        animationView.frame = bounds
    }
  
}
