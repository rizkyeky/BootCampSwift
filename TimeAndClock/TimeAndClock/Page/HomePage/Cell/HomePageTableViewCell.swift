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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
