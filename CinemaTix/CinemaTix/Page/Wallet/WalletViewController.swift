//
//  WalletViewController.swift
//  CinemaTix
//
//  Created by Eky on 06/11/23.
//

import UIKit

class WalletViewController: UIViewController {

    @IBOutlet weak var base: UIView!
    @IBOutlet weak var card: Card!

    @IBOutlet weak var topUpButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let amountText = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        
        runAnim()

        navigationItem.title = "Wallet"

        base.backgroundColor = .systemBlue
        
        card.makeCornerRadius(16)
        
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        card.addSubview(blurView)
        blurView.snp.makeConstraints { make in
            make.width.height.equalTo(card)
            make.top.left.right.bottom.equalTo(card)
        }
        
        amountText.text = "Rp5.000.000"
        amountText.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        amountText.textColor = .white
        
        card.addSubview(amountText)
        amountText.snp.makeConstraints { make in
            make.centerY.equalTo(self.card)
            make.right.equalTo(self.card).offset(-16)
        }
        
        topUpButton.setImage(SFIcon.forward, for: .normal)
        topUpButton.setTitle("Top Up", for: .normal)
        topUpButton.configuration?.imagePlacement = .trailing
        topUpButton.contentHorizontalAlignment = .fill
        topUpButton.setAnimateBounce()
        topUpButton.backgroundColor = .systemGroupedBackground
        topUpButton.makeCornerRadius(16)
    }
    
    func runAnim() {
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.fromValue = UIColor.systemBlue.cgColor
        animation.toValue = UIColor.clear.cgColor
        animation.duration = 1.0
        
        card.layer.add(animation, forKey: "colorChange")
    }
}

#if DEBUG

import SwiftUI

struct ViewController_Preview: PreviewProvider {
    static var previews: some View = Preview(for: WalletViewController())
        .preferredColorScheme(.light)
        .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
}

#endif
