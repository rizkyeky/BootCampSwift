//
//  PopUpViewController.swift
//  TimeAndClock
//
//  Created by Eky on 02/11/23.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var loadingView: CustomLoadingIndicator!
    @IBOutlet weak var barrier: UIView!
    
    var onTapBarrier: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingView.transform = CGAffineTransform(translationX: 0.0, y: self.view.frame.height)
        
        barrier.backgroundColor = .darkGray.withAlphaComponent(0.5)
        
        let barrierGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBarrier))
        barrier.addGestureRecognizer(barrierGesture)
        barrier.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showPopUp()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        hidePopUp()
    }
    
    func showPopUp() {
        loadingView.alpha = 0
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            self.loadingView.transform = .identity
            self.loadingView.alpha = 1
        }
    }
    
    func hidePopUp() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            self.loadingView.transform = CGAffineTransform(translationX: 0.0, y: self.view.frame.height)
            self.loadingView.alpha = 0
        }
    }
    
    @objc func didTapBarrier() {
        onTapBarrier?()
    }
    
}
