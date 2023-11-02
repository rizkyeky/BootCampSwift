//
//  PopUpView.swift
//  TimeAndClock
//
//  Created by Eky on 02/11/23.
//

import UIKit
import Lottie

@IBDesignable
class CustomLoadingIndicator: UIView {
    
    @IBOutlet weak var card1: UIView!
    @IBOutlet weak var card2: UIView!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var lottie: LottieAnimationView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView() {
        let view = self.loadNib()
        view.frame = self.bounds
        view.clipsToBounds = true
        self.addSubview(view)
        
        card1.layer.cornerRadius = 16
        card1.clipsToBounds = true
        
        card2.layer.cornerRadius = 16
        card2.clipsToBounds = true
        
        loadingIndicator.startAnimating()
        
        lottie.contentMode = .scaleAspectFit
        
        lottie.loopMode = .loop
        lottie.play()
    }
}
