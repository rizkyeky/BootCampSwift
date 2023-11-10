//
//  HomeTableViewCell2.swift
//  CinemaTix
//
//  Created by Eky on 09/11/23.
//

import UIKit

class HomeTableViewCell2: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    static let height = 60
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
