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
        setupOptionButton()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupMainCard() {
        mainCard.clipsToBounds = true
        mainCard.layer.cornerRadius = 16
        mainCard.layer.borderWidth = 0.5
        mainCard.layer.borderColor = UIColor.separator.cgColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapMainCard))
        mainCard.addGestureRecognizer(tapGesture)

    }
    
    func setupOptionButton() {
        optionButton.addTarget(self, action: #selector(didTapOptionButton), for: .touchUpInside)
    }
    
    @objc func didTapOptionButton() {
        onTapOptionButton?()
    }
    
    @objc func didTapMainCard() {
        onTapMainCard?()
    }
}
