//
//  WalletViewController.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import UIKit

class WalletViewController: UIViewController {

    @IBOutlet weak var base: UIView!
    @IBOutlet weak var card: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Wallet"
        
        base.backgroundColor = .blue.withAlphaComponent(0.3)
        
        card.makeCornerRadius(16)
        
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        card.addSubview(blurView)
        blurView.snp.makeConstraints { make in
            make.width.height.equalTo(card)
            make.top.left.right.bottom.equalTo(card)
        }
    }
}
