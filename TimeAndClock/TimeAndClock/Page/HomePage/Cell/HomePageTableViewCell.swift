//
//  HomePageTableViewCell.swift
//  TimeAndClock
//
//  Created by Eky on 30/10/23.
//

import UIKit

class HomePageTableViewCell: UITableViewCell {

    @IBOutlet weak var mainCard: UIView!
    @IBOutlet weak var leadingTitle: UILabel!
    @IBOutlet weak var optionButton: UIButton!
    
    var onTapOptionButton: (() -> Void)?
    var onTapMainCard: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupMainCard()
        
        optionButton.setTitle("", for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupMainCard() {
        mainCard.clipsToBounds = true
        mainCard.layer.cornerRadius = 16
        mainCard.layer.borderWidth = 0.5
        mainCard.layer.borderColor = UIColor.separator.cgColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapMainCard(_:)))
        mainCard.addGestureRecognizer(tapGesture)
        
        
    }
    
    @IBAction func didTapOptionButton(_ sender: UIButton) {
        onTapOptionButton?()
    }
    
    @objc func didTapMainCard(_ sender: UITapGestureRecognizer) {
        onTapMainCard?()
    
        if sender.state == .began {
            print("Pressed")
//            mainCard.onTapDownAnimateBounce()
        } else if sender.state == .ended {
            print("Released")
//            mainCard.onTapUpAnimateBounce()
        }
        
        UIView.animate(withDuration: 0.098, animations: {
            self.mainCard.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        }) { _ in
            UIView.animate(withDuration: 0.098, animations: {
                self.mainCard.transform = CGAffineTransform.identity
            })
        }
    }
}
