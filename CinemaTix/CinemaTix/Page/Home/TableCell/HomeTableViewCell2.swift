//
//  HomeTableViewCell2.swift
//  CinemaTix
//
//  Created by Eky on 09/11/23.
//

import UIKit

class HomeTableViewCell2: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    static let height = 60
    
    var onTap: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
            
        button.addAction(UIAction() { _ in
            self.onTap?()
        }, for: .touchUpInside)
        
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
